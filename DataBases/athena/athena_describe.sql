show create table de_dashboard_db.table_f;

CREATE EXTERNAL TABLE `de_dashboard_db.table_f`(
  `run_id` string,
  `first_party` string,
  `processing_status` string,
  `fail_reason` string,
  `region` string,
  `vendor` string,
  `data_feed` string,
  `table_name` string,
  `feed_id` string,
  `processed_date` string,
  `input_file_path` string,
  `output_file_path` string,
  `repository` string,
  `run_type` string,
  `hardware` string,
  `score_in` float,
  `evaluated_expectations_in` int,
  `successful_expectations_in` int,
  `unsuccessful_expectations_in` int,
  `input_row_count` string,
  `input_column_count` int,
  `score_out` float,
  `evaluated_expectations_out` int,
  `successful_expectations_out` int,
  `unsuccessful_expectations_out` int,
  `output_row_count` string,
  `output_column_count` int,
  `feed_starttime` timestamp,
  `feed_endtime` timestamp,
  `feed_runtime` int)
PARTITIONED BY (
  `dt` string)
ROW FORMAT DELIMITED
  FIELDS TERMINATED BY '\;'
STORED AS INPUTFORMAT
  'org.apache.hadoop.mapred.TextInputFormat'
OUTPUTFORMAT
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://spineds-testing/BUCKET/dashboard-logging/table_o/table_f/v1'
TBLPROPERTIES (
  'has_encrypted_data'='false',
  'skip.header.line.count'='1',
  'transient_lastDdlTime'='1593188258')


describe formatted de_dashboard_db.table_f;

# col_name            	data_type           	comment

run_id              	string
first_party         	string
processing_status   	string
fail_reason         	string
region              	string
vendor              	string
data_feed           	string
table_name          	string
feed_id             	string
processed_date      	string
input_file_path     	string
output_file_path    	string
repository          	string
run_type            	string
hardware            	string
score_in            	float
evaluated_expectations_in	int
successful_expectations_in	int
unsuccessful_expectations_in	int
input_row_count     	string
input_column_count  	int
score_out           	float
evaluated_expectations_out	int
successful_expectations_out	int
unsuccessful_expectations_out	int
output_row_count    	string
output_column_count 	int
feed_starttime      	timestamp
feed_endtime        	timestamp
feed_runtime        	int

# Partition Information
# col_name            	data_type           	comment

dt                  	string

# Detailed Table Information
Database:           	de_dashboard_db
Owner:              	hadoop
CreateTime:         	Fri Jun 26 16:17:38 UTC 2020
LastAccessTime:     	UNKNOWN
Protect Mode:       	None
Retention:          	0
Location:           	s3://spineds-testing/BUCKET/dashboard-logging/table_o/table_f/v1
Table Type:         	EXTERNAL_TABLE
Table Parameters:
	EXTERNAL            	TRUE
	has_encrypted_data  	false
	skip.header.line.count	1
	transient_lastDdlTime	1593188258

# Storage Information
SerDe Library:      	org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe
InputFormat:        	org.apache.hadoop.mapred.TextInputFormat
OutputFormat:       	org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat
Compressed:         	No
Num Buckets:        	-1
Bucket Columns:     	[]
Sort Columns:       	[]
Storage Desc Params:
	field.delim         	;
	serialization.format	;

