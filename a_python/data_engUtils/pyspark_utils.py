#!usr/bin/python3
# -*- coding: utf-8 -*-

import os
import boto3
from psutil import virtual_memory
from multiprocessing import cpu_count
from pyspark.sql import SparkSession
# Internal imports
from de_utils.gral_utils import log_to_file


def set_spark(emr_cluster=True):
    n_cpus = cpu_count()
    tot_mem = virtual_memory().total >> 30  # Bit shift to get values in GB

    cores_per_executor = 5 if n_cpus > 10 else 2
    mem_overhead_percent = 0.07

    ex_mem = tot_mem / cores_per_executor
    ex_mem = int(ex_mem - mem_overhead_percent * ex_mem)  # reserve 7% for yarn overhead

    log_to_file(f'Available cores:{n_cpus}')
    log_to_file(f'Total memory:{str(tot_mem)}GB')

    if emr_cluster:
        log_to_file("#" * 40 + "Running in cluster" + "#" * 40)
        log_to_file(f'Creating SparkSession in Cluster')
    else:
        log_to_file("#" * 40 + "Using single instance" + "#" * 40)
        log_to_file(f'Creating SparkSession in single Instance')

    spark = SparkSession.builder \
        .appName(f"Testing with PySpark") \
        .config('fs.s3a.connection.maximum', n_cpus) \
        .config('spark.default.parallelism', n_cpus * 4) \
        .config('spark.executor.memory', str(ex_mem) + 'g') \
        .config('spark.executor.cores', cores_per_executor) \
        .config('spark.num.executors', n_cpus // cores_per_executor) \
        .config('spark.driver.memory', "20g") \
        .config("spark.driver.maxResultSize", "4g") \
        .config("spark.executor.instances", cores_per_executor) \
        .config('spark.debug.maxToStringFields', 200) \
        .config('spark.sql.shuffle.partitions', 500) \
        .getOrCreate()

    # spark.sparkContext.getConf().get("spark.dynamicAllocation.enabled") -
    log_to_file("-" * 40 + "- SPARK CONFIG -" + "-" * 40)
    log_to_file(f'SparkSession params:{spark.sparkContext.getConf().getAll()}')
    log_to_file("-" * 40 + "- END SPARK CONFIG -" + "-" * 40)

    return spark


def read_df(spark, src, header=False, delimiter='\t', file_type='csv'):
    '''
    :param spark: created SparkSession
    :param src: path to the data
    :param header: True or False
    :param delimiter: csv delimiter: \t, ',', ';', '|', etc
    :param file_type: csv, parquet
    :return: spark dataframe
    '''

    log_to_file(f"Reading data from: {src}")

    if 'csv' in file_type:
        df = spark.read \
            .option('header', header) \
            .option('delimiter', delimiter) \
            .option('maxColumns', 40000) \
            .format(file_type) \
            .load(src)

    elif 'parquet' in file_type:
        df = spark.read.parquet(src)

    return df


def clean_emr_metadata(dest):
    s3_client = boto3.client('s3')
    s3_res = boto3.resource('s3')

    bucket = dest.replace('s3://', '').split('/')[0]
    prefix = '/'.join(dest.replace('s3://', '').split('/')[1:-2])  # Exclude dt

    print('Deleting _$folder$ keys generated by EMR from bucket {} '
          'and prefix {}'.format(bucket, prefix))

    resp = s3_client.list_objects_v2(
        Bucket=bucket,
        Prefix=prefix,
        MaxKeys=1000
    )

    while resp['KeyCount'] > 0:
        [s3_res.Object(bucket, obj['Key']).delete()
         for obj in resp['Contents']
         if obj['Key'].endswith('_$folder$')]

        resp = s3_client.list_objects_v2(
            Bucket=bucket,
            Prefix=prefix,
            MaxKeys=1000,
            StartAfter=resp['Contents'][-1]['Key']
        )


# WRITING TO HDFS AND THEN UPLOADING
def emr_write_dataframe(df, dest, spark):
    local_output = f'hdfs:///transformed/{dest}'
    log_to_file('Writing transformed DataFrame to {}'.format(local_output))

    # DEVf - Testing without repartition at all #
    df.write \
        .mode('overwrite') \
        .parquet(local_output)

    """df.repartition(num_parts).write \
        .mode('overwrite') \
        .parquet(local_output)"""

    spark.stop()

    log_to_file('Copying data into S3 using s3-dist-cp...')
    copy_cmd = f'/usr/bin/s3-dist-cp --src {local_output} --dest s3://{dest} --targetSize 128'
    log_to_file(f'Command: {copy_cmd}')
    os.system(copy_cmd)

    log_to_file('Removing data from HDFS...')
    rm_cmd = f'hdfs dfs -rm -r -f -skipTrash {local_output}'
    log_to_file('Command: {}'.format(rm_cmd))
    os.system(rm_cmd)

    clean_emr_metadata(f's3://{dest}')

    return True


def copy_s3_hdfs(src, dest):
    """
    Usage: s3-dist-cp --src s3://<bucket>/<prefix> --dest /<local_path>/
    """
    # os.system(f"echo {src} > /tmp/s3_dir.lst")
    # cmd = f"s3-dist-cp --src {src} --dest {dest} --srcPrefixesFile file:///tmp/s3_dir.lst --srcPattern=.*\.parquet"
    cmd = f"s3-dist-cp --src {src} --dest {dest}"
    log_to_file(f'copy_s3_hdfs - Executing:{cmd}')
    os.system(cmd)
