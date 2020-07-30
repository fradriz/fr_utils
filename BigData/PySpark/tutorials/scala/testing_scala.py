
# Using Scala UDFs in pyspark (this shows how to register an UDF and using it with SQL): https://medium.com/wbaa/using-scala-udfs-in-pyspark-b70033dd69b9

# Spark 2.3+ use the tag '2.1+'
from pyspark.sql.types import BooleanType
spark.udf.registerJavaFunction("validate_iban", "com.ing.wbaa.spark.udf.ValidateIBAN", BooleanType())

# Use your UDF!
spark.sql("""SELECT validate_iban('NL20INGB0001234567')""").show()

'''
How to Use Scala UDF and UDAF in PySpark: https://www.cyanny.com/2017/09/15/spark-use-scala-udf-udaf-in-pyspark/

Spark - Calling Scala code from PySpark: https://aseigneurin.github.io/2016/09/01/spark-calling-scala-code-from-pyspark.html

https://stackoverflow.com/questions/31684842/calling-java-scala-function-from-a-task

Using Scala code in PySpark applications: https://diogoalexandrefranco.github.io/scala-code-in-pyspark/

Spark Hot Potato: Passing DataFrames Between Scala Spark and PySpark: https://www.crowdstrike.com/blog/spark-hot-potato-passing-dataframes-between-scala-spark-and-pyspark/

https://stackoverflow.com/questions/36023860/how-to-use-a-scala-class-inside-pyspark

https://stackoverflow.com/questions/44346776/how-to-run-scala-script-using-spark-submit-similarly-to-python-script

https://stackoverflow.com/questions/32975636/how-to-use-both-scala-and-python-in-a-same-spark-project

Performance: https://stackoverflow.com/questions/32464122/spark-performance-for-scala-vs-python

Scala vs Python
http://emptypipes.org/2015/01/17/python-vs-scala-vs-spark/

https://mindfulmachines.io/blog/2018/6/apache-spark-scala-vs-java-v-python-vs-r-vs-sql26

https://github.com/archivesunleashed/aut/issues/215

https://datasciencevademecum.wordpress.com/2016/01/28/6-points-to-compare-python-and-scala-for-data-science-using-apache-spark/

https://www.coursera.org/learn/scala-spark-big-data

https://www.kdnuggets.com/2018/05/apache-spark-python-scala.html

https://stackoverflow.com/questions/32464122/spark-performance-for-scala-vs-python

https://stackoverflow.com/questions/30477982/python-vs-scala-for-spark-jobs

'''


