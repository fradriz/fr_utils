# Documentation 

https://docs.aws.amazon.com/emr/latest/ReleaseGuide/emr-spark-submit-step.html

How to create a cluster from CLI:
aws emr create-cluster --name "Add Spark Step Cluster" --release-label emr-5.30.1 --applications Name=Spark \
--ec2-attributes KeyName=myKey --instance-type m5.xlarge --instance-count 3 \
--steps Type=Spark,Name="Spark Program",ActionOnFailure=CONTINUE,\
    Args=[--class,org.apache.spark.examples.SparkPi,/usr/lib/spark/examples/jars/spark-examples.jar,10] \
--use-default-roles

As an alternative, you can use command-runner.jar as shown in the following example.
aws emr create-cluster --name "Add Spark Step Cluster" --release-label emr-5.30.1 \
--applications Name=Spark --ec2-attributes KeyName=myKey --instance-type m5.xlarge --instance-count 3 \
--steps Type=CUSTOM_JAR,Name="Spark Program",Jar="command-runner.jar",ActionOnFailure=CONTINUE,\
Args=[spark-example,SparkPi,10] --use-default-roles


Alternatively, add steps to a cluster already running. Use add-steps.
aws emr add-steps --cluster-id j-2AXXXXXXGAPLF --steps Type=Spark,Name="Spark Program",ActionOnFailure=CONTINUE,\
Args=[--class,org.apache.spark.examples.SparkPi,/usr/lib/spark/examples/jars/spark-examples.jar,10]