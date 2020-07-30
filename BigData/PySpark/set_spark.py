
from pyspark.sql import SparkSession
from multiprocessing import cpu_count
from psutil import virtual_memory

# Get Spark conf after cretaing the session:
#    spark.sparkContext.getConf().getAll()
##############################FUNCTION TO GENERATE SPARK SESSION###############
def set_spark():
    cores_per_executor = 5
    mem_overhead_percent = 0.07

    n_cpus = cpu_count()
    tot_mem = virtual_memory().total >> 30  # Bit shift to get values in GB

    ex_mem = tot_mem / cores_per_executor
    ex_mem = int(ex_mem - mem_overhead_percent * ex_mem)  # reserve 7% for yarn overhead

    print('Available cores:', n_cpus)
    print('Total memory:', str(tot_mem) + 'gb')

    spark = SparkSession.builder \
        .appName("Any name to use in the spark job") \
        .config('fs.s3a.connection.maximum', n_cpus) \
        .config('spark.executor.memory', str(ex_mem) + 'g') \
        .config('spark.executor.cores', cores_per_executor) \
        .config('spark.num.executors', n_cpus // cores_per_executor) \
        .config('spark.driver.memory', "20g") \
        .config("spark.driver.maxResultSize", "4g") \
        .config("spark.executor.instances", cores_per_executor) \
        .config('spark.debug.maxToStringFields', 200) \
        .config('spark.sql.shuffle.partitions', 500) \
        .getOrCreate()

    return spark