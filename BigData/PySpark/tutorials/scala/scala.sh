scala - BORRA

mandado por Yi para probar scala con python

$ aws s3 cp s3://spineds-testing/tf-test/tensorflow_test_bootstrap-4.sh -
sudo python3 -m pip install --upgrade pip setuptools wheel boto3 jupyter
sudo python3 -m pip uninstall spineds-lib --y

sudo yum -y install git-core
sudo python3 -m pip install tensorflow
sudo python3 -m pip install keras
sudo python3 -m pip install pandas==0.24.2

git config --global credential.helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true

clone_repo()
{
  REPO=$1
  BRANCH=$2
  REPOS_URL="https://git-codecommit.us-east-2.amazonaws.com/v1/repos/"
  CMD="git clone $REPOS_URL$REPO --single-branch --branch $BRANCH"
  cd ~/
  echo "$CMD"
  eval "$CMD"

}
#sleep $(($RANDOM % 15))

clone_repo "pcs-spineds-lib" "develop" # TODO: Back to master after dev
clone_repo "data-engineering-utils" "master" # TODO: Back to master after dev

cd ~/pcs-spineds-lib/ && sudo python3 -m pip install .
cd ~/data-engineering-utils/ && sudo python3 -m pip install .

aws s3 cp s3://BUCKET/cluster-manager/pcs-spineds-scala.jar ~/

#export SPARK_DIST_CLASSPATH=~/pcs-spineds-scala.jar
#export SPARK_HOME=/usr/lib/spark/
#export PYSPARK_DRIVER_PYTHON=/usr/bin/python3
#export PYSPARK_PYTHON=python3
#export PYSPARK=/usr/bin/pyspark


# alias python3=/usr/bin/pyspark

# sudo wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.3/hadoop-aws-2.7.3.jar -O $SPARK_HOME/jars/hadoop-aws-2.7.3.jar
# sudo wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk/1.11.759/aws-java-sdk-1.11.759.jar -O $SPARK_HOME/jars/aws-java-sdk-1.11.762.jarWKMAR2291368:~ facradri$

---------------
Scala

Agregar esto en pcs-spineds-feature > /src/scripts/vendor_comscore/census/features/categories_monthly_count/categories_monthly_count.py
	from spineds.scala.utils import *

Con Hyper (funciona ok)


################ scala.api #############################
# Esta es la importancion de funciones desde el proyecto de spineds.scala ...

from pyspark.sql import SparkSession
from spineds.scala.udfs import FeatureUDFS
from spineds.scala.analyses import Analyses
from spineds.scala.utils import FunctionsDF
from spineds.scala.services.services import Services


class ScalaAPI(object):

    def __init__(self):
        self._spark = SparkSession.builder.getOrCreate()
        self.udfs = FeatureUDFS()
        self.analyses = Analyses()
        self.functions = FunctionsDF()
        self.services = Services()
################ /scala.api #############################
# Ejemplo de uso de:
scala_api = ScalaAPI()

labeled_df = scala_api.services.hypertargeting.performance.cutoff_predict(
        scored_df, cutoff, prediction_col, "predicted_label"
    )



self._spark.sparkContext._jvm.pcs.spineds.scala.utils.FunctionsDF.vec2col(
                df._jdf,
                features,
                schema
            )

-------
Pure scala:
	* Not sure we want/need to take this step:
		pros:
			- it might be simpler to run the code purely in scala (not sure)
		cons:
			- we all need to start learning a new languaje and its frameworks
			- learning curve could be high, meaning that we are going to studying and not producing.
			- Scala developers are scarse.
			- According to benchmarks, scala is significativaly faster than python only when using UDFs or UDAFs (like in Sharthis)
			- a whole new orchestator in scala ?


My recomendation: make it work like now, python and some complicated UDFs in scala, no migrate teh whole code.