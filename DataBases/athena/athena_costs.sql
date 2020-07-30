-- Cost by gdm_activity_name including month
WITH
     AUX as (
         SELECT
            CASE WHEN gdm_instance_type like 'm5.large' THEN 0.096
                WHEN gdm_instance_type like 'm5.24xlarge' THEN 4.608
                ELSE 0
            END AS GDM_COST,

            CASE WHEN emr_master_instance_type like 'm4.4xlarge' THEN 0.8
                WHEN emr_master_instance_type like 'r5.12xlarge' THEN 3.024
                ELSE 0
            END AS EMR_MASTER_COST,

            CASE WHEN emr_master_instance_type like 'm4.4xlarge' THEN 0.8
                WHEN emr_master_instance_type like 'r5.12xlarge' THEN 3.024
                ELSE 0
            END AS EMR_CORE_COST,
            gdm_activity_name, gdm_instance_hours, emr_core_instance_hours, dt
            -- DATE(end_datetime) day
            -- repository, emr_master_instance_type,total_runtime
         FROM
            de_dashboard_db.table_o
    )

SELECT
    gdm_activity_name,
    count(gdm_instance_hours) run_num,
    round(sum((GDM_COST * gdm_instance_hours) + (EMR_CORE_COST * emr_core_instance_hours) + EMR_MASTER_COST),2) TOTAL_COST,
    dt
FROM
     AUX
GROUP BY gdm_activity_name, dt
ORDER BY TOTAL_COST DESC;

---
WITH
     AUX as (
         SELECT
            CASE WHEN gdm_instance_type like 'm5.large' THEN 0.096
                WHEN gdm_instance_type like 'm5.24xlarge' THEN 4.608
                ELSE 0
            END AS GDM_COST,

            CASE WHEN emr_master_instance_type like 'm4.4xlarge' THEN 0.8
                WHEN emr_master_instance_type like 'r5.12xlarge' THEN 3.024
                ELSE 0
            END AS EMR_MASTER_COST,

            CASE WHEN emr_master_instance_type like 'm4.4xlarge' THEN 0.8
                WHEN emr_master_instance_type like 'r5.12xlarge' THEN 3.024
                ELSE 0
            END AS EMR_CORE_COST,
            gdm_activity_name, gdm_instance_hours, emr_core_instance_hours,
            DATE(end_datetime) day
            -- repository, emr_master_instance_type,total_runtime
         FROM
            de_dashboard_db.table_o
    )

SELECT
    gdm_activity_name,
    --round((GDM_COST * gdm_instance_hours),2) GDM_COST_H,
    ceil(EMR_CORE_COST * emr_core_instance_hours) EMR_CORE_COST_H,
    --EMR_MASTER_COST,
    ceil((GDM_COST * gdm_instance_hours) + (EMR_CORE_COST * emr_core_instance_hours) + EMR_MASTER_COST) TOTAL_COST,
    day
FROM AUX
ORDER BY TOTAL_COST DESC;



--- Cost per month
WITH
     AUX as (
         SELECT
            CASE WHEN gdm_instance_type like 'm5.large' THEN 0.096
                WHEN gdm_instance_type like 'm5.24xlarge' THEN 4.608
                ELSE 0
            END AS GDM_COST,

            CASE WHEN emr_master_instance_type like 'm4.4xlarge' THEN 0.8
                WHEN emr_master_instance_type like 'r5.12xlarge' THEN 3.024
                ELSE 0
            END AS EMR_MASTER_COST,

            CASE WHEN emr_master_instance_type like 'm4.4xlarge' THEN 0.8
                WHEN emr_master_instance_type like 'r5.12xlarge' THEN 3.024
                ELSE 0
            END AS EMR_CORE_COST,
            gdm_activity_name, gdm_instance_hours, emr_core_instance_hours, dt
            -- DATE(end_datetime) day
            -- repository, emr_master_instance_type,total_runtime
         FROM
            de_dashboard_db.table_o
    )

SELECT
    dt,
    count(gdm_activity_name) run_num,
    round(sum((GDM_COST * gdm_instance_hours) + (EMR_CORE_COST * emr_core_instance_hours) + EMR_MASTER_COST),2) TOTAL_COST
FROM
     AUX
GROUP BY dt
ORDER BY TOTAL_COST DESC;


-- Now checking issues in table_f
SELECT
  run_id,
  vendor,
  data_feed,
  table_name,
  feed_id,
  processed_date,
  input_row_count,
  feed_endtime,
  feed_runtime,
  round(feed_runtime/3600.0,2) runtime_hour
FROM de_dashboard_db.table_f WHERE run_id LIKE '20200702051510_oel' ORDER BY feed_runtime desc;

