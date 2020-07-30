#!/usr/local/bin/python3
# -*- coding: utf-8 -*-

# In theory is a good practice. Problem: This method is too slow.
# Recommended solution: Just use in-built AWS S3 versioning.
# Script to move S3 data to a purge location in a bucket
# Is like a garbage bin location - we can delete the location once a week. ie: on Sundays at 5am.

# aws s3 mv s3://spineds-testing/tmp/experian/Q/dt=2019-11-27/ s3://spineds-testing/purge/tmp/experian/Q/dt=2019-11-27/ --recursive

import argparse
import os

def bool_type(v):
    if v.lower() in ('yes', 'true', 't', 'y', '1'):
        return True
    elif v.lower() in ('no', 'false', 'f', 'n', '0'):
        return False
    else:
        raise argparse.ArgumentTypeError('Boolean value expected.')


parser = argparse.ArgumentParser(description='Script to avoid data lost in S3')

parser.add_argument(
    '-s3p',
    dest='s3_path',
    help='S3 path to the data to purge. Format: s3://<bucket>/<prefix>',
    required=True
)

parser.add_argument(
    '-q',
    dest='quiet',
    help='Bool: Run quiet cmd',
    required=False,
    default=False,
    type=bool_type
)

parser.add_argument(
    '-dryrun',
    dest='dryrun',
    help='Bool: if true it won\'t execute the cmd, just showing what it\'ll do',
    required=False,
    default=False,
    type=bool_type
)

parser.add_argument(
    '-v',
    action='version',
    version='%(prog)s version 1.0'
)

args = parser.parse_args()

try:
    if not args.s3_path.startswith('s3'):
        raise Exception("Start path with 's3://'")

    args.s3_path = args.s3_path if args.s3_path.endswith('/') else args.s3_path + '/'

    BUCKET = args.s3_path.split('/')[2]
    PREFIX = '/'.join(args.s3_path.split('/')[3:])
    PURGE_LOCATION = "s3://" + BUCKET + "/purge/" + PREFIX
    cmd = f"aws s3 mv {args.s3_path} {PURGE_LOCATION} --recursive"

    if args.quiet:
        cmd = cmd + ' --quiet'

    if args.dryrun:
        cmd = cmd + ' --dryrun'

    print("Executing..")
    print(cmd)

    # os.system(cmd)
except Exception as e:
    print(f"ERROR - {e}")

