#!usr/bin/python3
# -*- coding: utf-8 -*-

import pyspark.sql.functions as F

# OBS: Could be a problem when reading if athena-output is in s3_src
# Partitions = dt=2020-07/
s3_src = "s3a://BUCKET/dashboard-logging/table_o/table_o/v1/"
s3_dst = "s3a://BUCKET/dashboard-logging/table_o/table_o/v2/"


# CSV options
infer_schema = "true"
first_row_is_header = "true"
delimiter = ";"

# The applied options are for CSV files. For other file types, these will be ignored.
df01 = spark.read.format("csv") \
  .option("inferSchema", infer_schema) \
  .option("header", first_row_is_header) \
  .option("sep", delimiter) \
  .load(s3_src)

df02 = df01.select(
    'run_id',
    'run_type',
    'service',
    'transform_type',
    'region',
    'repository',
    'hardware',
    F.lit('').alias('gdm_run_status'),
    F.lit('').alias('gdm_fail_reason'),
    'gdm_instance_type',
    'gdm_project_name',
    'gdm_activity_name',
    'gdm_resource_name',
    'gdm_instance_hours',
    'emr_cluster_size',
    'emr_master_instance_type',
    'emr_master_instance_hours',
    'emr_core_instance_type',
    'emr_core_instance_count',
    'emr_core_instance_hours',
    'emr_task_instance_type',
    'emr_task_instance_count',
    'emr_task_instance_hours',
    'emr_total_memory',
    'emr_max_memory_usage_percent',
    'emr_total_storage',
    'emr_max_storage_usage_percent',
    'start_datetime',
    'end_datetime',
    'total_runtime'
)

df02.repartition(1).\
    write.mode('overwrite').\
    format("csv").\
    option('header', True).\
    option("sep", ";").\
    option("emptyValue", "").\
    option("timestampFormat", "yyyy-MM-dd HH:mm:ss"). \
    save(s3_dst)
