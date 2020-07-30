-- Link: https://www.cloudera.com/documentation/enterprise/5-10-x/topics/impala_create_table.html
-- CTAS to copy a table into another
CREATE TABLE target_table
STORED as parquet as
select * from source_table;

-- Clone: To clone one table from another without any data use CTAS + LIKE:
CREATE TABLE dest_table LIKE source_table;

-- CTAS using 'with'
CREATE TABLE IF NOT EXISTS
    db_name.table_name
STORED AS PARQUET
LOCATION
    '<hdfs_path>/data/'
AS
WITH
     aux as (SELECT cast(CURRENT_TIMESTAMP as string))

select * from aux;

----------------------------------------------------------
-- Create External Table Parquet
set hivevar:PRODUCTION_DB=prod_dev;

DROP TABLE IF EXISTS ${hivevar:PRODUCTION_DB}.table_name;

CREATE EXTERNAL TABLE `${hivevar:PRODUCTION_DB}.table_name` (
    `id` string,
    `field1` int,
    `field2` string,
    `field3` string)
--STORED AS PARQUET
ROW FORMAT SERDE
  'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe'
STORED AS INPUTFORMAT
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat'
OUTPUTFORMAT
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat'
LOCATION
  'hdfs://nameservice1/<hdfs_path>/data';

--Update statistics
ANALYZE TABLE ${hivevar:PRODUCTION_DB}.table_name COMPUTE STATISTICS;

--To set THRESHOLD validation (metadata property to use later)
alter table  ${hivevar:PRODUCTION_DB}.table_name set TBLPROPERTIES  ('name.threshold'='10%');



----------------------------------------------------------
-- Create an AVRO partitioned table using schema
--Setting variables to use later
set hivevar:DATABASE=db_name;
set hivevar:TABLE1=table_name1;
set hivevar:TABLE_NAME=${hivevar:TABLE1}_borra;
set hivevar:SCHEMA_LOCATION='<hdfs_path_to_schema>/${hivevar:TABLE1}.avsc';
set hivevar:LOCATION_IN_HDFS='<hdfs_path>/${hivevar:TABLE1}/data/';

--Create a partitioned table
CREATE EXTERNAL TABLE
    ${hivevar:DATABASE}.${hivevar:TABLE_NAME}
PARTITIONED BY
    (archive int)
ROW FORMAT SERDE
    'org.apache.hadoop.hive.serde2.avro.AvroSerDe'
WITH SERDEPROPERTIES
    ('avro.schema.url'=${hivevar:SCHEMA_LOCATION})
STORED as AVRO
LOCATION
    ${hivevar:LOCATION_IN_HDFS};

--Update data in the partiton (i.e. archive=20180606)
msck repair table ${hivevar:DATABASE}.${hivevar:TABLE_NAME}

--Check the table
select * from ${hivevar:DATABASE}.${hivevar:TABLE_NAME} where archive > 1;
select count(*) from ${hivevar:DATABASE}.${hivevar:TABLE_NAME} where archive > 1;
describe formatted ${hivevar:DATABASE}.${hivevar:TABLE_NAME};
show partitions ${hivevar:DATABASE}.${hivevar:TABLE_NAME};
--Delete the table
drop table ${hivevar:DATABASE}.${hivevar:TABLE_NAME};