import os
import math
import sys
import yaml
import argparse
import getpass
from string import Template
import datetime as DT
from pyhive import hive
from vertica_python import Connection

#Get connection parametter
def get_args():
    parser = argparse.ArgumentParser(description='Migration validator', add_help=False)
    default_hostname = os.environ.get('VSQL_HOSTNAME') or 'localhost'
    default_port = os.environ.get('VSQL_PORT') or 15532
    default_password = os.environ.get('VSQL_PASSWORD')
    default_username = os.environ.get('VSQL_USER') or getpass.getuser()
    parser.add_argument('--help', action='store_true')
    parser.add_argument('-h', '--host', default=default_hostname)
    parser.add_argument('-p', '--port', default=default_port, type=int)
    parser.add_argument('-U', '--username', default=default_username)
    parser.add_argument('-w', '--password', default=default_password)
    parser.add_argument('-db', '--database', default='uberhouse')
    #parser.add_argument('-q', '--query', required=True)
    #Adding default parameters for sources and destination folder
    #default_yaml=os.environ['UBER']+'/piper-core-pipelines/dwm/hive_etl/config/jobs/raw_data'
    parser.add_argument('-src_yaml', '--src_yaml', default=default_yaml)
    default_job='rush_pool_match'
    parser.add_argument('-job', '--job', default=default_job)


    args = parser.parse_args()
    if args.help:
        parser.print_help()
        return None
    if args.password is None:
        args.password = getpass.getpass()
    return args

#-------------------MAIN-------------------

#Connect parameter for vertica
args = get_args()
global creds
creds = {'user': args.username, 'password': args.password,
         'host': args.host, 'port': args.port,
         'database': args.database}

#Connect parameter for hive
hive_user_name=args.username
hive_host = args.host
#Sources Yaml file
folder_src=args.src_yaml