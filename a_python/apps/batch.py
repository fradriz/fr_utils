from math import ceil

from pyspark.sql import SparkSession
spark = SparkSession.builder.getOrCreate()

idmap_data = 's3a://client-smuckers-audienceinsights-us-9979/toolbox-output/idmap/20200728203902TaylorKelley/idmap/'
idmap = spark.read.parquet(idmap_data).select("synthetic_key_16_hashed", "idl_orig", "dunkin").filter("synthetic_key_16_hashed not like 'model_%'")

proscore_jif = spark.read.parquet('s3a://core-data-us/vendor-iri/proscore/segment/') \
    .select('synthetic_key_16_hashed', 'brand').filter("brand = 'Jif'")

s3_dir = 's3a://spineds-testing/client-smuckers-audienceinsights-us-9979/TK/dunkin/'

# Do not broadcast idmap
mrgd = proscore_jif.join(idmap, proscore_jif.synthetic_key_16_hashed == idmap.synthetic_key_16_hashed) \
    .drop(idmap.synthetic_key_16_hashed).select('synthetic_key_16_hashed', 'idl_orig', 'dunkin', 'brand')

'''
# Calculating parition size - want files of 128 MB each
fst = mrgd.first()
file_size = 128*(2**20)
col_size = sum(len(str(fst.asDict()[cl])) for cl in mrgd.columns)
row_num = mrgd.count()
N = ceil(col_size * row_num / file_size)
print(f"File size={file_size // (2 ** 20)} MiB \t Aprox col_size={col_size} \t Row size={row_num:,} \t Partitions:{N}")
'''

mrgd.repartition(8).write.mode('overwrite').parquet(s3_dir + 'iri_proscorejif_9d_ids/')
