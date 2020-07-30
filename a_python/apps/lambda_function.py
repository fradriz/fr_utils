import json
import boto3

from botocore.vendored import requests


# Taking out problematic chars from json file
def remove_reserved_chars(dict_file):
    chars_to_remove = "'{\"}`"
    fields_to_check = ["clientIndustry", "modelDescription", "modelName", "processEmail"]

    for key in dict_file:
        if type(dict_file[key]) is str and key in fields_to_check:
            for rem in chars_to_remove:
                dict_file[key] = dict_file[key].replace(rem, " ")

    return dict_file


def launch_gdm_job(bucket, config):
    DEV_gdm_project_name = 'DEV-AIS-Service-Runner'
    DEV_gdm_project_api_key = 'CIkTQj5i9sBfzBF6cKhmv3EJwa4ZOOm2wM'

    PROD_gdm_project_name = 'PROD-AIS-Service-Runner'
    PROD_gdm_project_api_key = 'zJYrcrkbwNGOWI1KCrAeTYn1JhUyX1F3Se'

    gdm_project_name = DEV_gdm_project_name if bucket == 'spineds-testing' \
        else PROD_gdm_project_name

    gdm_project_api_key = DEV_gdm_project_api_key if bucket == 'spineds-testing' \
        else PROD_gdm_project_api_key

    gdm_user_id = '5d2f4a6bbd57de0001cde515'
    gdm_url = 'http://ge-admin-api-us-east-1-analytics.ppc.COMPANY.com' \
              '/analytics/start_execution'

    headers = {
        'x-api-key': gdm_project_api_key,
        'x-gdm-user-id': gdm_user_id
    }

    return requests.post(
        url=gdm_url,
        params=dict(project_name=gdm_project_name),
        headers=headers,
        data=json.dumps(dict(JSON_FILE=config))
    )


def lambda_handler(event, context):
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']

    print(f'Processing: Bucket: {bucket} - Key: {key}')
    s3 = boto3.client('s3')

    # Read content and remove file
    obj = s3.get_object(Bucket=bucket, Key=key)
    config = json.loads(obj['Body'].read())
    s3.delete_object(Bucket=bucket, Key=key)

    config = remove_reserved_chars(config)

    # Launch GDM job
    resp = launch_gdm_job(bucket, config)

    # Write content to processed S3 prefix
    s3.put_object(
        Bucket=bucket,
        Body=json.dumps(config).encode('utf8'),
        Key=key.replace('json-dropzone', 'json-processed')
    )

    print('Response status code:', resp.status_code,
          '\nResponse text:', resp.text)

    return dict(status_code=resp.status_code, text=resp.text)
