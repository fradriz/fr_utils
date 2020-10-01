
--If table 'taxonomy' has a field 'data' which is array-struct:
-- data: array (nullable = true)
-- |    |-- element: struct (containsNull = true)

SELECT
    d.*
FROM
    taxonomy t lateral view inline (t.data) d;

-- This works also in Spark SQL with 'df.createOrReplaceTempView("taxonomy")' and with built-in UDF:
-- import pyspark.sql.functions as f
-- df.select(f.explode('data')).select(f.col('col.*'))


'''
df.show(5)
+----------+--------------------+-----------+------------+--------------+----------+-----------+-----+--------------------+--------------+--------------+--------------------+--------------------+------------+--------------------+------+--------------------+----+-------+--------+
|accessible|   available_options|category_id|category_ids|          code|core_study|    devices|flags|           full_name|            id|knowledge_base|        location_ids|             message|mobile_study|                name|notice|            suffixes|unit|warning|wave_ids|
+----------+--------------------+-----------+------------+--------------+----------+-----------+-----+--------------------+--------------+--------------+--------------------+--------------------+------------+--------------------+------+--------------------+----+-------+--------+
|      true|[[true, q2_1, 639...|        347| [347, 6402]|            q2|     false|all_devices|   []|Which of the foll...|            q2|          null|[s2_1, s2_2, s2_2...|Since Q2 2009. Th...|       false|              Gender|  null|                null|null|   null|      []|
|      true|[[true, q1029a_1,...|       7885|      [7885]|gwi-ext.q1029a|     false|all_devices|   []|Which of these sp...|gwi-ext.q1029a|          null|[s2_1, s2_2, s2_2...|From Q1 2017 - Q2...|       false|Sports Brands: Aw...|  null|                null|null|   null|      []|
|      true|[[true, q1014a_1,...|       1809|      [1809]|gwi-ext.q1014a|     false|all_devices|   []|Do you currently ...|gwi-ext.q1014a|          null|[s2_1, s2_2, s2_2...|Since Q1 2017. Th...|       false|  Financial Products|  null|[[1, 1,, Yes, 0],...|null|   null|      []|
|      true|[[true, q25_17, 8...|       3471|      [3471]|           q25|     false|all_devices|   []|Here is a list of...|           q25|          null|                  []|Q1 2011 - Q2 2018...|       false|Personal Interest...|  null|                null|null|   null|      []|
|      true|[[true, q4142_23,...|       3474|      [3474]|         q4142|     false|all_devices|   []|Which of the foll...|         q4142|          null|[s2_1, s2_2, s2_2...|Q4 2014 - Q2 2018...|       false|Sports Leagues / ...|  null|[[1, 1,, Follow, ...|null|   null|      []|
+----------+--------------------+-----------+------------+--------------+----------+-----------+-----+--------------------+--------------+--------------+--------------------+--------------------+------------+--------------------+------+--------------------+----+-------+--------+
only showing top 5 rows
'''

--To get what is 'available_options' (array of strings):
SELECT
    *
FROM
    taxonomy t lateral view inline (t.data) dd lateral view explode (dd.available_options) ao;

