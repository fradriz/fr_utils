import inspect
import os
import csv
import json
import time
import boto3
from datetime import datetime
import urllib.request
from a_python.data_engUtils.emr_cluster import CLUSTER_SIZE_CONFIGS


def get_gdm_fields(logger):
    gdm_params = {}

    gmd_instance_type = urllib.request. \
        urlopen("http://169.254.169.254/latest/meta-data/instance-type/").read().decode()
    try:
        with open(f'/tmp/gdm_params.json', 'r') as f:
            gdm_params = json.load(f)
            f.close()
    except FileNotFoundError as fe:
        msg = f"{fe} - can't load gdm params"
        if logger:
            logger.warning('global', msg)
        else:
            print(msg)
    gdm_params["gmd_instance_type"] = gmd_instance_type

    return gdm_params


def athena_query(query, BUCKET, PREFIX, region):
    athena_output = f's3://{BUCKET}/{PREFIX.split("dt")[0]}athena_output/'
    athena_client = boto3.client('athena', region)
    database = 'de_dashboard_db_testing' if 'spineds-testing' in BUCKET else 'de_dashboard_db'

    response = athena_client.start_query_execution(
        QueryString=query,
        QueryExecutionContext={
            'Database': database
        },
        ResultConfiguration={
            'OutputLocation': athena_output
        }
    )

    return response


def get_ge_values(run_summary):
    """
    :param run_summary:
    :return: dictionary with ge values
        eg. {'score_in': 0.0, 'evaluated_expectations_in': 3, 'successful_expectations_in': 0,
        'unsuccessful_expectations_in': 3, 'input_row_count': '44,783', 'input_column_count': 58}
    """
    ge_dashboard_data = {}
    input_row_count = input_column_count = output_row_count = output_column_count = '-'

    det_in = run_summary[f'ge_input']
    det_out = run_summary[f'ge_output']

    if 'No GE' not in det_in:
        ge_dashboard_data.update(
            score_in=det_in['score'],
            evaluated_expectations_in=det_in['evaluated_expectations'],
            successful_expectations_in=det_in['successful_expectations'],
            unsuccessful_expectations_in=det_in['unsuccessful_expectations']
        )

        for det in det_in['details']:
            input_row_count = \
                f"{det['observed_value']}" if 'row_count' in det['expectation_type'] else input_row_count
            input_column_count = \
                det['observed_value'] if 'column_count' in det['expectation_type'] else input_column_count

        ge_dashboard_data['input_row_count'] = input_row_count
        ge_dashboard_data['input_column_count'] = input_column_count

    if 'No GE' not in det_out:
        ge_dashboard_data.update(
            score_out=det_out['score'],
            evaluated_expectations_out=det_out.get('evaluated_expectations'),
            successful_expectations_out=det_out.get('successful_expectations'),
            unsuccessful_expectations_out=det_out.get('unsuccessful_expectations')
        )

        for det in det_out['details']:
            output_row_count = \
                f"{det['observed_value']}" if 'row_count' in det['expectation_type'] else output_row_count
            output_column_count = \
                det['observed_value'] if 'column_count' in det['expectation_type'] else output_column_count

        ge_dashboard_data['output_row_count'] = output_row_count
        ge_dashboard_data['output_column_count'] = output_column_count

    return ge_dashboard_data


def save_dashboard_data(data_dict_list, region, logger, test, table):
    table_version = 'v2' if table == 'table_0' else 'v1'
    current_func = inspect.currentframe().f_code.co_name

    s3 = boto3.client('s3')

    logger.warning('global', f'{current_func} - Starting .."')

    for run_summary in data_dict_list:
        cluster_name = run_summary.get("cluster_name", '')
        service = 'ais' if 'AIS' in cluster_name else run_summary.get("service")

        # Tables path: s3://bucket/dashboard-logging/table_o/table_f/v1/dt=YYYY-MM/
        partition = run_summary['date'][0:7] if 'table_f' in table else datetime.utcnow().strftime('%Y-%m')
        file_name = f'{run_summary["run_id"]}_{table}_{partition.replace("-","")}.csv'
        prefix_part = f'dashboard-logging/{service}/{table}/{table_version}/dt={partition}/{file_name}'
        BUCKET = 'spineds-testing' if test else 'bucket'
        KEY = f'bucket/{prefix_part}' if test else f'{prefix_part}'

        try:
            if 'table_f' in table:
                # Renaming some columns
                run_summary['processing_status'] = run_summary.pop('status')
                run_summary['fail_reason'] = run_summary.pop('reason')
                run_summary['processed_date'] = run_summary.pop('date')
                run_summary['region'] = region
                ge_dashboard_data = get_ge_values(run_summary)
                # print(f"PRINTING GE DASHBOARD DATA:{ge_dashboard_data}")

                run_summary.update(
                    score_in=ge_dashboard_data.get('score_in'),
                    evaluated_expectations_in=ge_dashboard_data.get('evaluated_expectations_in'),
                    successful_expectations_in=ge_dashboard_data.get('successful_expectations_in'),
                    unsuccessful_expectations_in=ge_dashboard_data.get('unsuccessful_expectations_in'),
                    input_row_count=ge_dashboard_data.get('input_row_count'),
                    input_column_count=ge_dashboard_data.get('input_column_count'),
                    score_out=ge_dashboard_data.get('score_out'),
                    evaluated_expectations_out=ge_dashboard_data.get('evaluated_expectations_out'),
                    successful_expectations_out=ge_dashboard_data.get('successful_expectations_out'),
                    unsuccessful_expectations_out=ge_dashboard_data.get('unsuccessful_expectations_out'),
                    output_row_count=ge_dashboard_data.get('output_row_count'),
                    output_column_count=ge_dashboard_data.get('output_column_count')
                )

                # Selecting only the keys I want in the dashboard
                dashboard_columns = [
                    'run_id',
                    'first_party',
                    'processing_status',
                    'fail_reason',
                    'region',
                    'vendor',
                    'data_feed',
                    'table_name',
                    'feed_id',
                    'processed_date',
                    'input_file_path',
                    'output_file_path',
                    'repository',
                    'run_type',
                    'hardware',
                    'score_in',
                    'evaluated_expectations_in',
                    'successful_expectations_in',
                    'unsuccessful_expectations_in',
                    'input_row_count',
                    'input_column_count',
                    'score_out',
                    'evaluated_expectations_out',
                    'successful_expectations_out',
                    'unsuccessful_expectations_out',
                    'output_row_count',
                    'output_column_count',
                    'feed_starttime',
                    'feed_endtime',
                    'feed_runtime']
                run_summary = {dashboard_key: run_summary[dashboard_key] for dashboard_key in dashboard_columns}

            file_path = f'{os.environ["HOME"]}/{file_name}'
            exist_file = os.path.isfile(file_path)

            with open(file_path, 'a') as f:
                w = csv.DictWriter(f, run_summary.keys(), delimiter=';')
                if not exist_file:
                    w.writeheader()
                w.writerow(run_summary)
            f.close()

            # Upload file to S3
            logger.info('global', f'{current_func} - Uploading dashboard file to s3://{BUCKET}/{KEY}')
            s3.upload_file(
                Filename=file_path,
                Bucket=BUCKET,
                Key=KEY
            )

        except Exception as e:
            # This error will not stop the flow
            logger.warning('global', f'{current_func} - Error writing dashboard table "{table}" - "{e}"')

        try:
            # Only updating athena partitions in us-east-1 and if it doesn't exist
            PREFIX = KEY.split(file_name)[0]
            athena_partition_exist = s3.list_objects_v2(Bucket=BUCKET, Prefix=PREFIX).get('KeyCount')

            if 'us-east-1' in region and not athena_partition_exist:
                query = f"MSCK REPAIR TABLE {table};"
                logger.info('global', f" {current_func} - Updating Athena DB partitions executing:'{query}'")
                response = athena_query(query, BUCKET, KEY, region)
                msg = f"{current_func} - Athena query executed:" \
                      f"StatusCode:{response['ResponseMetadata']['HTTPStatusCode']}"
                logger.info('global', msg)

        except Exception as e:
            # This error will not stop the flow
            logger.warning('global', f'{current_func} - Error updating Athena partitions in table "{table}" - "{e}"')


def dashboard_values(logger, **kwargs):
    st = kwargs.pop('st')
    region = kwargs['region']
    cluster_size = kwargs.get('cluster_size')
    source = kwargs.get('source')
    emr = kwargs['emr']

    dt_format = "%Y-%m-%d %H:%M:%S"
    start_time = time.strftime(dt_format, time.gmtime(st))
    et = time.time()
    end_time = time.strftime(dt_format, time.gmtime(et))
    total_runtime = int(et - st)  # secs

    cluster_size_config = CLUSTER_SIZE_CONFIGS.get(cluster_size)
    instance_type = cluster_size_config['InstanceType'] if cluster_size_config else None
    instance_count = cluster_size_config['InstanceCount'] if cluster_size_config else None

    gdm_params = get_gdm_fields(logger)
    gdm_project_name = gdm_params.get("gdm_project_name")

    if 'service_emr_launcher' in source:
        table = 'table_name'
        logger.info('global', f'{source} - Generating params for dashboard')

        dashboard_data = dict(
            run_id=kwargs['run_id'],
            run_type='DEV' if 'DEV' in gdm_project_name else 'PROD',
            hardware='emr_cluster' if kwargs.get('emr') else 'single_instance',
            cluster_name=kwargs.get('cluster_name'),
            gdm_run_status=kwargs.get('gdm_run_status'),
            gdm_fail_reason=kwargs.get('gdm_fail_reason'),
            gdm_instance_type=gdm_params.get("gmd_instance_type"),
            gdm_project_name=gdm_project_name,
            gdm_activity_name=gdm_params.get("gdm_activity_name"),
            gdm_resource_name=gdm_params.get("gdm_resource_name"),
            gdm_instance_hours=0.0,
            emr_cluster_size=cluster_size,
            emr_master_instance_type=instance_type,
            emr_master_instance_hours=0.0,
            emr_core_instance_type=instance_type,
            emr_core_instance_count=instance_count,
            emr_core_instance_hours=0.0,
            emr_task_instance_type='',
            emr_task_instance_count='',
            emr_task_instance_hours=0.0
        )
    else:
        table = 'table_o'
        # table_o / table_o_emr_launcher
        dashboard_data = dict(
            run_id=kwargs['run_id'],
            run_type='DEV' if kwargs.get('test_qty') else 'PROD',
            service='table_o',
            transform_type=kwargs.get('transform_type'),
            region=kwargs.get('region'),
            repository=kwargs.get('repository'),
            hardware='emr_cluster' if kwargs.get('emr') else 'single_instance',
            gdm_run_status=kwargs.get('gdm_run_status'),
            gdm_fail_reason=kwargs.get('gdm_fail_reason'),
            gdm_instance_type=gdm_params.get("gmd_instance_type"),
            gdm_project_name=gdm_project_name,
            gdm_activity_name=gdm_params.get("gdm_activity_name"),
            gdm_resource_name=gdm_params.get("gdm_resource_name"),
            gdm_instance_hours=0.0,
            emr_cluster_size=cluster_size,
            emr_master_instance_type=instance_type,
            emr_master_instance_hours=0.0,
            emr_core_instance_type=instance_type,
            emr_core_instance_count=instance_count,
            emr_core_instance_hours=0.0,
            emr_task_instance_type='',
            emr_task_instance_count='',
            emr_task_instance_hours=0.0,
            emr_total_memory='',
            emr_max_memory_usage_percent='',
            emr_total_storage='',
            emr_max_storage_usage_percent=''
        )

    dashboard_data['start_datetime'] = start_time
    dashboard_data['end_datetime'] = end_time
    dashboard_data['total_runtime'] = total_runtime
    dashboard_data['gdm_instance_hours'] = round(total_runtime / 3600, 2)

    if emr:
        dashboard_data['emr_master_instance_hours'] = dashboard_data['gdm_instance_hours']
        dashboard_data['emr_core_instance_hours'] = \
            round((total_runtime * dashboard_data['emr_core_instance_count']) / 3600, 2)

    msg = f'{source} - Writing "{table}" table:"{dashboard_data}"'
    print(msg)
    logger.info('global', msg)
    test = dashboard_data['run_type'] == 'DEV'
    save_dashboard_data([dashboard_data], region, logger, test, table=table)
