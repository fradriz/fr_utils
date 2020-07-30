-- Alter table ...
-- Link:https://cwiki.apache.org/confluence/display/Hive/LanguageManual+DDL#LanguageManualDDL-RenamePartition

-- Rename Partition Name:
ALTER TABLE table_name PARTITION partition_spec RENAME TO PARTITION partition_spec;

-- Modify location:
ALTER TABLE <nombre_tabla> set location <nuevo_path>

--Move HDFS location:
ALTER TABLE <nombre_tabla> set tblproperties ('avro.schema.url'='<NEW_PATH_IN_HDFS>')

--RENAME a table name:
-- To change a table name in Hive, table must be internal or a managed.
-- If the table is external the best is to change it to internal and rename the table.

--Turn external table to managed
ALTER TABLE old_table_name SET TBLPROPERTIES('EXTERNAL'='FALSE');
-- ALTER table name
ALTER TABLE old_table_name RENAME TO new_table_name;
--Turn back table into external
ALTER TABLE new_table_name SET TBLPROPERTIES('EXTERNAL'='TRUE');

-- Drop partition
ALTER TABLE table_name DROP PARTITION (archive=20180717);
