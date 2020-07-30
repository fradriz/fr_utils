#!usr/bin/python3
# -*- coding: utf-8 -*-

"""
Adding the sparse vectors
We want to build an udf that receives an array with sparse vectors:
    [(909, [1,5,6], [1.0, 1.0, 1.0]),(909, [1,2,6], [1.0, 1.0, 1.0])]

and to transform it into the following by adding them:
    (909, [1,2,5,6], [2.0, 1.0, 1.0, 2.0])

Helpful link: https://stackoverflow.com/questions/32981875/how-to-add-two-sparse-vectors-in-spark-using-python/36141206
"""
import sys

import pyspark.sql.functions as F
from pyspark.ml.linalg import Vectors, SparseVector, VectorUDT
from collections import defaultdict

from a_python.de_utils.gral_utils import log_to_file
from a_python.de_utils.pyspark_utils import set_spark


# UDF to add the features in the vector
def sum_sparse_vectors(v1, v2):
    # Initializing a dictionary with default value 0.0
    values = defaultdict(float)

    try:
        # Checking v1 and v2 types and sizes
        # if condition returns False, AssertionError is raised:
        assert isinstance(v1, SparseVector) and isinstance(v2, SparseVector)
        assert v1.size == v2.size

        # Add values from v1
        for i in range(v1.indices.size):
            values[v1.indices[i]] += v1.values[i]
        # Add values from v2
        for i in range(v2.indices.size):
            values[v2.indices[i]] += v2.values[i]

    # If data doesn't come as expected (AssertionError or other)..
    # ..inform the problem in stderr, leave it empty and continue
    except AssertionError:
        sys.stderr.write("WARNING - AssertionError")

    except Exception as e:
        sys.stderr.write(f"ERROR:{e}")

    return Vectors.sparse(v1.size, dict(values))


@F.udf(returnType=VectorUDT())
def sum_features(features):
    first = True
    for f in features:
        added_features = f if first else sum_sparse_vectors(added_features, f)
        first = False

    return added_features


def adding_vectors():
    feature_location = "<bucket>/<prefix>/"
    start_dt = "2020-01-01"
    end_dt = "2020-02-01"

    spark = set_spark()

    ft = f"dt BETWEEN DATE'{start_dt}' AND DATE'{end_dt}'"
    log_to_file(f'Reading data from {feature_location} and apply the filter:{ft}..')

    df = spark.read \
        .parquet('s3a://' + feature_location) \
        .filter(ft)

    log_to_file("# Create a view or table and group the vectors in an array by id")
    df.createOrReplaceTempView("df")
    df_aggregated = spark.sql("""
                  select
                    id,
                    collect_list(
                            features
                    ) as features
                  from df
                  group by id
                  """)

    log_to_file("# After vectors are grouped, apply the UDF defined above.")
    df_out = df_aggregated.select("id", sum_features("features").alias("features"))
    df_out.show(5)

    return True
