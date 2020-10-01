#!usr/bin/python3
# -*- coding: utf-8 -*-

import os
import json
import logging
import argparse


def log_to_file(msg, severity_type='info'):
    """
    level=logging.DEBUG
    level=logging.INFO *
    level=logging.WARNING
    level=logging.ERROR *
    level=logging.CRITICAL

    Usage: log_to_file(msg)
    """

    log_file = f'{os.environ["HOME"]}/testing_log_file.log'

    ff = "%(asctime)s - %(levelname)s - %(message)s"
    logging.basicConfig(filename=log_file, level=logging.INFO, filemode='a', format=ff, datefmt='%Y-%m-%d %H:%M:%S')
    # logging.basicConfig(filename=sys.stdout, level=logging.INFO, filemode='a', format=ff, datefmt='%Y-%m-%d %H:%M:%S')

    if severity_type == 'info':
        logging.info(msg)
    elif severity_type == 'warning':
        logging.warning(msg)
    elif severity_type == 'error':
        logging.error(msg)
    else:
        logging.error("wrong severity_type for message '{msg}'".format(msg=msg))

    # Printing to stdout
    print(msg)


def args_params():
    # Link: https://docs.python.org/3/library/argparse.html
    parser = argparse.ArgumentParser(
        description='Gral description'
    )

    # Group of mandatory args ??
    mandatory_args = parser.add_argument_group('Mandatory arguments')
    mandatory_args.add_argument(
        '-region',
        dest='region',
        choices=['us-east-1', 'eu-west-1', 'ap-southeast-2'],
        help='AWS region to be processed',
        required=True
    )

    # Non mandatory arguments
    # Strings definitions
    parser.add_argument(
        '-any_string',
        dest='string',
        help='Any string you want to add - not requiered',
        required=False
    )

    '''
    Lists - Expected outputs
        # This is the correct way to handle accepting multiple arguments.
            # '+' == 1 or more.
            # '*' == 0 or more.
            # '?' == 0 or 1.

        $ python arg.py --nargs 1234 2345 3456 4567
        ['1234', '2345', '3456', '4567']

        $ python arg.py --nargs-int-type 1234 -2345 3456 4567
        [1234, -2345, 3456, 4567]
    '''
    # An int is an explicit number of arguments to accept.
    parser.add_argument('--nargs', nargs='+')

    # To make the input integers
    parser.add_argument('--nargs-int-type', nargs='+', type=int)

    '''
    Dictionaries
    '''
    parser.add_argument('-d', '--my-dict', type=json.loads)

    args = parser.parse_args()
    mydict = args.my_dict  # Will return a dictionary !!


def io_files():
    # Json files
    try:
        with open(f'/tmp/gdm_params.json', 'r') as f:
            gdm_params = json.load(f)
            f.close()
    except FileNotFoundError as fe:
        msg = f"{fe} - can't load gdm params"
        # logger.warning('global', msg)
        log_to_file(f"{fe} - {msg}")


def json_operations():
    '''
    Link: https://www.w3schools.com/python/python_json.asp
    When you convert from Python to JSON, Python objects are converted into the JSON (JavaScript) equivalent:
        Python	        JSON
        --------      ----------
        dict	        Object
        list	        Array
        tuple	        Array
        str	            String
        int	            Number
        float	        Number
        True	        true
        False	        false
        None	        null

    # print(json.dumps(hypertargeting_format_file, indent=4, sort_keys=False))
    '''
    ################ Convert from JSON to Python ################
    # some JSON:
    x = '{ "name":"John", "age":30, "city":"New York"}'

    # parse x:
    y = json.loads(x)

    # the result is a Python dictionary:
    print(y["age"])

    ################# Convert from Python to JSON ################
    # a Python object (dict):
    x = {
        "name": "John",
        "age": 30,
        "city": "New York"
    }

    # convert into JSON:
    y = json.dumps(x)

    # the result is a JSON string:
    print(y)

    ################# Convert Python objects into JSON strings, and print the values: #################
    print(json.dumps({"name": "John", "age": 30}))
    print(json.dumps(["apple", "bananas"]))
    print(json.dumps(("apple", "bananas")))
    print(json.dumps("hello"))
    print(json.dumps(42))
    print(json.dumps(31.76))
    print(json.dumps(True))
    print(json.dumps(False))
    print(json.dumps(None))

    ################# Convert a Python object containing all the legal data types: #################
    x = {
        "name": "John",
        "age": 30,
        "married": True,
        "divorced": False,
        "children": ("Ann", "Billy"),
        "pets": None,
        "cars": [
            {"model": "BMW 230", "mpg": 27.5},
            {"model": "Ford Edge", "mpg": 24.1}
        ]
    }
    print(json.dumps(x))

    ################# Format the Result (dicts) #################
    json.dumps(x, indent=4)
    json.dumps(x, indent=4, separators=(". ", " = "))

    ################# Order the Result (dicts) #################
    json.dumps(x, indent=4, sort_keys=True)


def rotLeft(a, d):
    '''
    HackerRank challenge: PracticeInterview > Preparation > KitArraysArrays: Left Rotation
    :param a: array, eg [1,2,3,4,5]
    :param d: shift positions, eg 2
    :return: shifted array 'd' times, eg [3, 4, 5, 1, 2]
    '''
    return (a[d:] + a[:d])