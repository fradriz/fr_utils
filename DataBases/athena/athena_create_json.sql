-- For AIS
--Not partitioned is working fine
CREATE EXTERNAL TABLE de_dashboard_db_testing.aisfrontend (
    processRunId string,
    service string,
    Description string,
    agencyEntity string,
    agencyName string,
    clientRegion string,
    clientCountry string,
    clientIndustry string,
    clientProject string,
    clientName string,
    clientUser string,
    audienceFirstParty string,
    processRunDateTime string
 )
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
WITH SERDEPROPERTIES ('ignore.malformed.json' = 'true')
LOCATION 's3://BUCKET/processing/ais/json-processed/';

MSCK REPAIR TABLE de_dashboard_db_testing.aisfrontend;

DROP TABLE de_dashboard_db_testing.aisfrontend;


