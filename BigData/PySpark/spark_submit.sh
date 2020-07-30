# To run pyspark code from cli ..
# Get the version with $ spark-submit --version

spark-submit --master yarn \
             --deploy-mode client \
             --conf fs.s3a.connection.maximum=500 \
             --conf spark.executor.memory=34g \
             --conf spark.executor.cores=5 \
             --conf spark.num.executors=9 \
             --conf spark.driver.memory=20g \
             --conf spark.driver.maxResultSize=4g \
             --conf spark.executor.instances=5 \
             --conf spark.debug.maxToStringFields=200 \
             --conf spark.sql.shuffle.partitions=500 \
             --py-files pyapp.py -param_1 'aa' -param_2 bb


             hadoop dist-copy


