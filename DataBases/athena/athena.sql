-- Datetime functions: https://prestodb.io/docs/current/functions/datetime.html
--Checking AIS
select
 b.cluster_name,
 --b.run_id,
 --f.service,
 f.clientcountry,
 b.emr_core_instance_type,
 b.emr_core_instance_hours,
 b.gdm_run_status,
 b.gdm_fail_reason,
 b.end_datetime as time_stamp,
 round(b.total_runtime/60,1) as mins
FROM
 de_dashboard_db.aisbackend b JOIN de_dashboard_db.aisfrontend f ON b.run_id = f.processrunid
WHERE
 b.run_id like '%Juan%'
ORDER BY
 b.end_datetime desc;

--table_o & table_f
SELECT
    o.run_id,
    o.service,
    o.region,
    o.repository,
    o.gdm_project_name,
    o.gdm_activity_name,
    o.emr_core_instance_hours,
    o.end_datetime,
    f.processing_status,
    f.vendor,
    f.data_feed,
    f.feed_id as country,
    f.processed_date,
    f.input_row_count,
    f.output_row_count,
    f.feed_runtime,
    f.feed_endtime,
    o.total_runtime
FROM
 de_dashboard_db.table_o o JOIN de_dashboard_db.table_f f ON o.run_id = f.run_id
WHERE DATE(o.end_datetime) = CURRENT_DATE
ORDER BY o.end_datetime DESC;

--FoundationalDataIngestion is the one that cost more
select
 o.run_id, o.gdm_project_name, o.gdm_resource_name, o.gdm_activity_name, o.region, o.repository, f.vendor, f.data_feed, f.table_name, f.processed_date,
 DATE(f.feed_endtime) run_date, round(f.feed_runtime/60,2) min
from de_dashboard_db.table_o o JOIN de_dashboard_db.table_f f ON o.run_id = f.run_id
where gdm_activity_name like 'Found%'
order by f.feed_runtime desc;

--Grouping by data
select
 o.gdm_activity_name, o.region, o.repository, f.vendor, f.data_feed, f.table_name,
 DATE(f.feed_endtime) run_date, sum(f.feed_runtime/60) min
from de_dashboard_db.table_o o JOIN de_dashboard_db.table_f f ON o.run_id = f.run_id
where gdm_activity_name like 'Found%'
group by o.gdm_activity_name, o.region, o.repository, f.vendor, f.data_feed, f.table_name, DATE(f.feed_endtime) run_date
order by f.feed_runtime desc

-- Checking rows per day
SELECT 'table_o' tabl, DATE(end_datetime) day, count(*) num FROM de_dashboard_db.table_o GROUP BY DATE(end_datetime)
UNION ALL
SELECT 'table_f', DATE(feed_endtime), count(*) FROM de_dashboard_db.table_f GROUP BY DATE(feed_endtime)
ORDER BY day desc;

-- Querying current or specific day table_o or table_f
SELECT * FROM de_dashboard_db.table_o WHERE DATE(end_datetime) = CURRENT_DATE order by end_datetime desc;
SELECT * FROM de_dashboard_db.table_o WHERE DATE(end_datetime) = DATE '2020-07-04' order by end_datetime desc;


SELECT * FROM de_dashboard_db.table_f WHERE DATE(feed_endtime) = CURRENT_DATE order by feed_endtime desc;
SELECT * FROM de_dashboard_db.table_f WHERE DATE(feed_endtime) = DATE '2020-07-04' order by feed_endtime desc;

-- Querying last day data
SELECT * FROM de_dashboard_db.table_o WHERE DATE(end_datetime) > CURRENT_DATE - interval '1' day;

SELECT * FROM de_dashboard_db.table_f WHERE DATE(feed_endtime) > CURRENT_DATE - interval '1' day;

-- Getting last 12 hours data
SELECT * FROM de_dashboard_db.table_o WHERE end_datetime > CURRENT_TIMESTAMP  - interval '12' hour
order by end_datetime desc ;

SELECT * FROM de_dashboard_db.table_f WHERE feed_endtime > CURRENT_TIMESTAMP  - interval '12' hour
order by feed_endtime desc ;

-- Filtering by time
SELECT * FROM de_dashboard_db.table_o WHERE end_datetime > timestamp '2020-06-26';

SELECT * FROM de_dashboard_db.table_o WHERE DATE(end_datetime) = timestamp '2020-06-26';

SELECT * FROM de_dashboard_db.table_o WHERE run_id like '%oel' ORDER BY end_datetime desc;

SELECT * FROM de_dashboard_db_testing.table_f ORDER BY feed_endtime desc;

SELECT * FROM de_dashboard_db.table_o WHERE end_datetime > timestamp '2020-06-26';

SELECT * FROM de_dashboard_db.table_o WHERE DATE(end_datetime) = timestamp '2020-06-26';

SELECT * FROM de_dashboard_db.table_o WHERE run_id like '%oel' ORDER BY end_datetime desc;


--Joining both table_o and table_f tables
SELECT
       o.run_id,
       o.repository,
       processing_status,
       vendor, data_feed, table_name, feed_id,
       processed_date, feed_endtime,
       feed_runtime, round(o.total_runtime/60.0,2) min, round(o.total_runtime/3600.0,2) hs,
       f.dt
FROM
   de_dashboard_db.table_o o left join de_dashboard_db.table_f f on o.run_id = f.run_id
WHERE
      o.run_id like '20200704062940_oel'
ORDER BY feed_endtime;

--Getting table_f total run_time
SELECT
    run_id,
    sum(feed_runtime) secs, round(sum(feed_runtime)/60.0,2) min, round(sum(feed_runtime)/3600.0,2) hs
FROM
     de_dashboard_db.table_f
WHERE
      run_id like '20200702051533_oel'
GROUP BY
         run_id;

--AIS: Read date -> processRunDateTime is a string with this format:'2020-07-06 16:52'
select processRunId, CAST(processRunDateTime as TIMESTAMP) from de_dashboard_db_testing.aisfrontend;
select processRunId, date_parse(processRunDateTime,'%Y-%m-%d %H:%i') from de_dashboard_db_testing.aisfrontend;

select
   processRunId,
   processRunDateTime,
   DATE(CAST(processRunDateTime as TIMESTAMP)) Day,
   --HOUR(CAST(processRunDateTime as TIMESTAMP)) || ':' || MINUTE(CAST(processRunDateTime as TIMESTAMP)),
   HOUR(CAST(processRunDateTime as TIMESTAMP)) Hs,
   MINUTE(CAST(processRunDateTime as TIMESTAMP)) Min
from de_dashboard_db_testing.aisfrontend

-- AIS jobs launched in the last two days
select *
from de_dashboard_db_testing.aisfrontend
where DATE(CAST(processRunDateTime as TIMESTAMP)) > CURRENT_DATE - interval '2' day;

-- AIS clients that is using it more
select clientuser, count(*) run_num
from de_dashboard_db_testing.aisfrontend
group by clientuser
order by count(*) desc


---- Move data to a new schema table


-- Insert old data in a new table changing the columns (schema)
-- This will sent the data to data location + dt=__HIVE_DEFAULT_PARTITION__/
-- I couldn't find the way to insert in the desired partition. I copied the data from __HIVE... to dt=2020-06 and
-- ran msck repair and worked (don't like it though)
-- # Athena: SELECT timestamp '2020-06-25 14:56:14' ColName;

INSERT INTO de_dashboard_db.table_o
    (run_id,
     run_type,
     service,
     transform_type,
     region,
     repository,
     hardware,
     gdm_instance_type,
     gdm_project_name,
     gdm_activity_name,
     gdm_resource_name,
     gdm_instance_hours,
     emr_cluster_size,
     emr_master_instance_type,
     emr_master_instance_hours,
     emr_core_instance_type,
     emr_core_instance_count,
     emr_core_instance_hours,
     start_datetime,
     end_datetime,
     total_runtime)
SELECT
    run_id,
    run_type,
    service,
    transform_type,
    region,
    repository,
    hardware,
    gdm_instance_type,
    gdm_project_name,
    gdm_activity_name,
    gdm_resource_name,
    gdm_instance_hours,
    emr_cluster_size,
    emr_master_instance_type,
    emr_master_instance_hours,
    emr_core_instance_type,
    emr_core_instance_count,
    emr_core_instance_hours,
    start_datetime,
    end_datetime,
    total_runtime
FROM de_dashboard_db.old_table_o where dt = '2020-06';





