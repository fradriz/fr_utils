# Useful comments for AWS Lambda


## Logs
Link: https://docs.aws.amazon.com/lambda/latest/dg/python-logging.html

import os

def lambda_handler(event, context):
    print('## ENVIRONMENT VARIABLES')
    print(os.environ)
    print('## EVENT')
    print(event)