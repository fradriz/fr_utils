
-- Renew metastore data:
INVALIDATE METADATA table_name;

-- Some times, this not working and exiting with the following message:
--      "Error = couldn't deserialize thrift msg:TProtocolException: Invalid data" when running:
select count(*) from table_name;

-- In this case, is useful to execute:
REFRESH table_name
