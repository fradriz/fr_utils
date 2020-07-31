# Documentation 

## Use Ganglia to test/benchmark EMR cluster resources

Create an SSH tunnel:

$ ssh -i .ssh/kp-private-key.pem -NL 80:localhost:8088 hadoop@ec2-3-236-133-47.compute-1.amazonaws.com

Access to ganglia from local host: $ http://localhost:50070/ganglia/

Another way is to us a SOCK tunnel + proxy (foxyproxy) (https://docs.aws.amazon.com/emr/latest/ReleaseGuide/view_Ganglia.html)

ssh -i .ssh/kp-private-key.pem -N -D 8157 hadoop@ec2-3-236-133-47.compute-1.amazonaws.com

But I couldn't make it work..

## Create clusters
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