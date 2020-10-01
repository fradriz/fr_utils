#!/usr/local/bin/python3
# -*- coding: utf-8 -*-

#####################################################################################
#                                                                                   #
# Print AIS Json file when having the run_id. Without run_id just print the folder  #
# Mac location: /usr/local/bin/aisj                                                 #
#                                                                                   #
#####################################################################################

import os
import argparse

BUCKET = 'data-engineering-9979'

# 1) must enter run_id as argument eg: 20200709190048YiRenCheng
parser = argparse.ArgumentParser(
    description='Print AIS json file in the screen console.',
    usage='\t%(prog)s [-s] <service name> [-run_id] <run_id> [-h] [-v]\n\n'
    )

# mandatory_args = parser.add_argument_group('Mandatory arguments')

parser.add_argument(
    '-run_id',
    help='run_id will tell which file to read',
    required=False
)

parser.add_argument(
    '-service', '-s',
    dest='service',
    help='AIS service to list:'
         'idmap(i), profiling(p), segmentation(s), hypertargeting(h), batch(b)',
    required=False
)

parser.add_argument(
    '-v',
    action='version',
    version='%(prog)s version 1.0'
)

args = parser.parse_args()

services = {'i': 'idmap',
            'p': 'profiling',
            's': 'segmentation',
            'h': 'hypertargeting',
            'b': 'batch'}

# 2) List the AWS S3 path and select the right file
S3_PATH = f's3://{BUCKET}/processing/ais/json-processed/'

if args.service:
    aux = services.get(args.service)
    service = aux if aux else args.service
    cmd = f'aws s3 ls {S3_PATH} | grep {service}'
    print(cmd)
    os.system(cmd)

elif args.run_id:
    files = os.popen(f'aws s3 ls {S3_PATH} | grep {args.run_id}').read()

    if files:
        json_file = None
        for f in files.split(' '):
            json_file = f[:-1] if args.run_id in f else None

        cmd = f'aws s3 cp {S3_PATH}{json_file} - | python -m json.tool'
        print(cmd)
        os.system(cmd)

    else:
        print(f"\nNo such file with run_id='{args.run_id}' in {S3_PATH}\n")
else:
    # No run_id, listing the s3 path
    cmd = f'aws s3 ls {S3_PATH}'
    print(cmd)
    os.system(cmd)