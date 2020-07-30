-- Source:?https://www.cloudera.com/documentation/enterprise/5-8-x/topics/impala_show.html

--Show tables can use like statament but wildards are '*' and | (not %)
show tables in <DB> like 'pattern'
--For example
show tables in db_name like 'table_*'

--Only in Impala (not hive)
show files in db.table