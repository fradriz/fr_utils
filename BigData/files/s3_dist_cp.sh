S3DistCp - BORRA

Once we had chosen S3DistCp, we had to update our ETL process to include it in our jobflow. Luckily, the S3DistCp documentation has an example on aggregating CloudFront files:

./elastic-mapreduce --jobflow j-3GY8JC4179IOK --jar \
/home/hadoop/lib/emr-s3distcp-1.0.jar \
--args '--src,s3://myawsbucket/cf,\
--dest,hdfs:///local,\
--groupBy,.*XABCD12345678.([0-9]+-[0-9]+-[0-9]+-[0-9]+).*,\
--targetSize,128,\
--outputCodec,lzo,--deleteOnSuccess'
Note that as well as aggregating the small files into 128 megabyte files, this step also changes the encoding to LZO. As the Amazon documentation explains it:

“Data compressed using LZO can be split into multiple maps as it is decompressed, so you don’t have to wait until the compression is complete, as you do with Gzip. This provides better performance when you analyze the data using Amazon EMR.”

We only needed to make a few changes to this example code for our own ETL:

We can’t predict the prefix on the CloudFront log files - and it certainly won’t be XABCD12345678, so it made more sense to drop this
Grouping files to the hour is overkill - we can roll up to the day and S3DistCp will happily split files if they are larger than targetSize
--deleteOnSuccess is dangerous - we don’t want to delete our source data and leave the only copy on a transient Hadoop cluster

---------------------------------
Testing upload speed

Very Fast !!
Si copio la data distcp desde S3 al cluster tardo menos de 2' !!
Velocidad: 116 GB / 2 min ==> 58 GB/min
$ aws s3 ls s3://core-data-us/vendor-experian/consumer-view/segment-labeled/dt=2019-08-28b/ --human-readable
..
2020-04-27 12:35:54  142.2 MiB part-00835-86791b62-0b83-4037-b5cd-99a7418463da-c000.snappy.parquet
..

Total Objects: 837
   Total Size: 116.1 GiB


COPIO
2020-04-27 17:46:40 - INFO - ----------------------------------------- END SPARK CONFIG -----------------------------------------
2020-04-27 17:46:40 - INFO - Downloading from s3://core-data-us/vendor-experian/consumer-view/segment-labeled/dt=2019-08-28b/ to HDFS in /expQ/2019-08-28/
2020-04-27 17:46:40 - INFO - copyS3_HDFS - Executing:s3-dist-cp --src s3://core-data-us/vendor-experian/consumer-view/segment-labeled/dt=2019-08-28b/ --dest /expQ/2019-08-28/
2020-04-27 17:48:11 - INFO - Transforming the data ..
2020-04-27 17:48:18 - INFO - ######################################### THE END ###################



ESTO TARDA UN MONTON !!
date; s3-dist-cp --src s3://gdm-gi-ingestion-us-east-1-prod/service/comscore_us_s3/company_ga/web_traffic/2020/04/08/ --dest /d^Ca02/;date


[hadoop@ip-172-31-10-180 ~]$ date; hadoop fs -ls -h /d^Ca02/
Sat Apr 25 16:57:10 UTC 2020
Found 1 items
-rw-r--r--   1 hadoop hadoop      3.6 G 2020-04-25 16:49 /d^Ca02/DGCS_USWebTraffic_20200408_01.dat.gz
[hadoop@ip-172-31-10-180 ~]$ date; hadoop fs -ls -h /d^Ca02/
Sat Apr 25 16:59:17 UTC 2020
Found 1 items
-rw-r--r--   1 hadoop hadoop      4.8 G 2020-04-25 16:49 /d^Ca02/DGCS_USWebTraffic_20200408_01.dat.gz
[hadoop@ip-172-31-10-180 ~]$ date; hadoop fs -ls -h /d^Ca02/
Sat Apr 25 17:00:06 UTC 2020
Found 1 items
-rw-r--r--   1 hadoop hadoop      5.1 G 2020-04-25 16:49 /d^Ca02/DGCS_USWebTraffic_20200408_01.dat.gz


Tardó: 3 minutos en subir 1.5 GB => 1.5/3 = 0.5 GB/min

-------------
time s3-dist-cp --src s3://gdm-gi-ingestion-us-east-1-prod/service/comscore_us_s3/company_ga/web_traffic/2020/04/08/ --dest /data03/ --multipartUploadChunkSize=1024

time s3-dist-cp --src /data/gb200 --dest s3://my-tables/data/S3DistCp/gb200_2 --multipartUploadChunkSize=1000


[hadoop@ip-172-31-10-180 ~]$ date; hadoop fs -ls -h /data03/
Sat Apr 25 17:05:53 UTC 2020
Found 1 items
-rw-r--r--   1 hadoop hadoop      128 M 2020-04-25 17:05 /data03/DGCS_USWebTraffic_20200408_01.dat.gz
[hadoop@ip-172-31-10-180 ~]$ date; hadoop fs -ls -h /data03/
Sat Apr 25 17:06:02 UTC 2020
Found 1 items
-rw-r--r--   1 hadoop hadoop      256 M 2020-04-25 17:05 /data03/DGCS_USWebTraffic_20200408_01.dat.gz
[hadoop@ip-172-31-10-180 ~]$ date; hadoop fs -ls -h /data03/
Sat Apr 25 17:07:24 UTC 2020
Found 1 items
-rw-r--r--   1 hadoop hadoop      896 M 2020-04-25 17:05 /data03/DGCS_USWebTraffic_20200408_01.dat.gz
[hadoop@ip-172-31-10-180 ~]$ date; hadoop fs -ls -h /data03/
Sat Apr 25 17:09:14 UTC 2020
Found 1 items
-rw-r--r--   1 hadoop hadoop      1.8 G 2020-04-25 17:05 /data03/DGCS_USWebTraffic_20200408_01.dat.gz



TARDO: 1.8 GB en 4 minutos => 1.8/4 = 0.45

----------------
[hadoop@ip-172-31-10-180 ~]$ cat testing_log_file.log
2020-04-25 14:50:57 - INFO - ######################################### STARTING .. #########################################
2020-04-25 14:50:57 - INFO - Available cores:48
2020-04-25 14:50:57 - INFO - Total memory:373GB
2020-04-25 14:50:57 - INFO - ########################################Running in cluster########################################
2020-04-25 14:50:57 - INFO - Creating SparkSession in Cluster
2020-04-25 14:51:09 - INFO - ----------------------------------------- SPARK CONFIG -----------------------------------------
2020-04-25 14:51:10 - INFO - SparkSession params:[('spark.driver.appUIAddress', 'http://ip-172-31-10-180.ec2.internal:4040'), ('spark.blacklist.decommissioning.enabled', 'true'), ('spark.hadoop.mapreduce.fileoutputcommitter.algorithm.version.emr_internal_use_only.EmrFileSystem', '2'), ('spark.eventLog.enabled', 'true'), ('spark.driver.host', 'ip-172-31-10-180.ec2.internal'), ('spark.default.parallelism', '192'), ('spark.yarn.executor.memoryOverheadFactor', '0.1875'), ('spark.driver.extraLibraryPath', '/usr/lib/hadoop/lib/native:/usr/lib/hadoop-lzo/lib/native'), ('spark.executor.cores', '5'), ('spark.sql.parquet.output.committer.class', 'com.amazon.emr.committer.EmrOptimizedSparkSqlParquetOutputCommitter'), ('spark.driver.port', '45577'), ('spark.blacklist.decommissioning.timeout', '1h'), ('spark.num.executors', '9'), ('spark.yarn.appMasterEnv.SPARK_PUBLIC_DNS', '$(hostname -f)'), ('spark.org.apache.hadoop.yarn.server.webproxy.amfilter.AmIpFilter.param.PROXY_HOSTS', 'ip-172-31-10-180.ec2.internal'), ('spark.sql.emr.internal.extensions', 'com.amazonaws.emr.spark.EmrSparkSessionExtensions'), ('spark.executorEnv.PYTHONPATH', '{{PWD}}/pyspark.zip<CPS>{{PWD}}/py4j-0.10.7-src.zip'), ('spark.executor.extraJavaOptions', "-verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=70 -XX:MaxHeapFreeRatio=70 -XX:+CMSClassUnloadingEnabled -XX:OnOutOfMemoryError='kill -9 %p'"), ('spark.eventLog.dir', 'hdfs:///var/log/spark/apps'), ('fs.s3a.connection.maximum', '48'), ('spark.sql.hive.metastore.sharedPrefixes', 'com.amazonaws.services.dynamodbv2'), ('spark.sql.warehouse.dir', 'hdfs:///user/spark/warehouse'), ('spark.serializer.objectStreamReset', '100'), ('spark.submit.deployMode', 'client'), ('spark.history.fs.logDirectory', 'hdfs:///var/log/spark/apps'), ('spark.ui.filters', 'org.apache.hadoop.yarn.server.webproxy.amfilter.AmIpFilter'), ('spark.sql.parquet.fs.optimized.committer.optimization-enabled', 'true'), ('spark.executor.memory', '69g'), ('spark.driver.extraClassPath', '/usr/lib/hadoop-lzo/lib/*:/usr/lib/hadoop/hadoop-aws.jar:/usr/share/aws/aws-java-sdk/*:/usr/share/aws/emr/emrfs/conf:/usr/share/aws/emr/emrfs/lib/*:/usr/share/aws/emr/emrfs/auxlib/*:/usr/share/aws/emr/goodies/lib/emr-spark-goodies.jar:/usr/share/aws/emr/security/conf:/usr/share/aws/emr/security/lib/*:/usr/share/aws/hmclient/lib/aws-glue-datacatalog-spark-client.jar:/usr/share/java/Hive-JSON-Serde/hive-openx-serde.jar:/usr/share/aws/sagemaker-spark-sdk/lib/sagemaker-spark-sdk.jar:/usr/share/aws/emr/s3select/lib/emr-s3-select-spark-connector.jar'), ('spark.org.apache.hadoop.yarn.server.webproxy.amfilter.AmIpFilter.param.PROXY_URI_BASES', 'http://ip-172-31-10-180.ec2.internal:20888/proxy/application_1587824830082_0001'), ('spark.hadoop.mapreduce.fileoutputcommitter.cleanup-failures.ignored.emr_internal_use_only.EmrFileSystem', 'true'), ('spark.ui.proxyBase', '/proxy/application_1587824830082_0001'), ('spark.history.ui.port', '18080'), ('spark.shuffle.service.enabled', 'true'), ('spark.hadoop.yarn.timeline-service.enabled', 'false'), ('spark.resourceManager.cleanupExpiredHost', 'true'), ('spark.executor.id', 'driver'), ('spark.sql.shuffle.partitions', '500'), ('spark.executor.extraClassPath', '/usr/lib/hadoop-lzo/lib/*:/usr/lib/hadoop/hadoop-aws.jar:/usr/share/aws/aws-java-sdk/*:/usr/share/aws/emr/emrfs/conf:/usr/share/aws/emr/emrfs/lib/*:/usr/share/aws/emr/emrfs/auxlib/*:/usr/share/aws/emr/goodies/lib/emr-spark-goodies.jar:/usr/share/aws/emr/security/conf:/usr/share/aws/emr/security/lib/*:/usr/share/aws/hmclient/lib/aws-glue-datacatalog-spark-client.jar:/usr/share/java/Hive-JSON-Serde/hive-openx-serde.jar:/usr/share/aws/sagemaker-spark-sdk/lib/sagemaker-spark-sdk.jar:/usr/share/aws/emr/s3select/lib/emr-s3-select-spark-connector.jar'), ('spark.files.fetchFailure.unRegisterOutputOnHost', 'true'), ('spark.app.id', 'application_1587824830082_0001'), ('spark.app.name', 'Testing with PySpark'), ('spark.driver.extraJavaOptions', "-XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=70 -XX:MaxHeapFreeRatio=70 -XX:+CMSClassUnloadingEnabled -XX:OnOutOfMemoryError='kill -9 %p'"), ('spark.master', 'yarn'), ('spark.decommissioning.timeout.threshold', '20'), ('spark.executor.instances', '5'), ('spark.stage.attempt.ignoreOnDecommissionFetchFailure', 'true'), ('spark.rdd.compress', 'True'), ('spark.yarn.historyServer.address', 'ip-172-31-10-180.ec2.internal:18080'), ('spark.driver.memory', '20g'), ('spark.debug.maxToStringFields', '200'), ('spark.executor.extraLibraryPath', '/usr/lib/hadoop/lib/native:/usr/lib/hadoop-lzo/lib/native'), ('spark.yarn.isPython', 'true'), ('spark.dynamicAllocation.enabled', 'true'), ('spark.driver.maxResultSize', '4g'), ('spark.hadoop.fs.s3.getObject.initialSocketTimeoutMilliseconds', '2000')]
2020-04-25 14:51:10 - INFO - ----------------------------------------- END SPARK CONFIG -----------------------------------------
2020-04-25 14:51:10 - INFO - Reading gdm-gi-ingestion-us-east-1-prod/service/comscore_us_s3/company_ga/web_traffic/2020/04/08/ data
2020-04-25 14:51:15 - INFO - Transforming the data ..
2020-04-25 14:51:15 - INFO - Writing the data to spineds-testing/tmp/csm/
2020-04-25 14:51:15 - INFO - Writing transformed DataFrame to hdfs:///transformed/spineds-testing/tmp/csm/
2020-04-25 16:21:44 - INFO - Copying data into S3 using s3-dist-cp...
2020-04-25 16:21:44 - INFO - Command: /usr/bin/s3-dist-cp --src hdfs:///transformed/spineds-testing/tmp/csm/ --dest s3://spineds-testing/tmp/csm/ --targetSize 128
2020-04-25 16:24:26 - INFO - Removing data from HDFS...
2020-04-25 16:24:26 - INFO - Command: hdfs dfs -rm -r -f -skipTrash hdfs:///transformed/spineds-testing/tmp/csm/
2020-04-25 16:24:30 - INFO - Finish writing the data to S3
2020-04-25 16:24:30 - INFO - ######################################### THE END #########################################