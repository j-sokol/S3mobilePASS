#!/usr/bin/env python
# coding=utf-8

import argparse
import os
import sys

import configparser
import boto3


from .utils.activation_code import InvalidActivationKey, MissingActivationKey
from .utils.token_generation import generate_mobilepass_token


CONFIG_FILE_NAME = ".mobilepasser.cfg"
CONFIG_FILE = os.path.expanduser("~/{}".format(CONFIG_FILE_NAME))
INDEX = 0
POLICY = ''
LENGTH = 6
UPDATE = False

parser = argparse.ArgumentParser(description='A reimplementation of the MobilePASS client in Python.')
parser.add_argument('-c', '--config-file', type=str, default=CONFIG_FILE,
                    help='Path to the configuration file.')
parser.add_argument('-k', '--activation-key', type=str,
                    help='The string the MobilePass client generated.')
parser.add_argument('-x', '--index', type=int,
                    help='The index of the token to generate.')
parser.add_argument('-p', '--policy', type=str,
                    help='Policy for the token.')
parser.add_argument('-l', '--otp-length', type=int,
                    help='Length of the returned OTP.')
parser.add_argument('-a', '--auto-update-index', action="store_true",
                    help='Automatically bump the index by 1 and save to config file.')

parser.add_argument('-s', '--s3', type=bool, default=False,
                    help='Load and save configuration to S3.')


args = parser.parse_args()
Config = configparser.ConfigParser({
    'index': str(INDEX),
    'policy': POLICY,
    'otp_length': str(LENGTH),
    'auto_update_index': str(UPDATE),
    'load_from_s3': str(False)
})


def read_config(Config):
    pass

def main():
    key = None
    index = INDEX
    policy = POLICY
    length = LENGTH
    update = UPDATE


    Config.read(args.config_file)
    if Config.has_section('MobilePASS'):
        if Config.has_option('MobilePASS', 'activation_key'):
            key = Config.get('MobilePASS', 'activation_key')
        index = Config.getint('MobilePASS', 'index')
        policy = Config.get('MobilePASS', 'policy')
        length = Config.getint('MobilePASS', 'otp_length')
        update = Config.getboolean('MobilePASS', 'auto_update_index')
        load_from_s3 = Config.getboolean('MobilePASS', 'load_from_s3')
        s3_bucket_name = Config.get('MobilePASS', 's3_bucket_name')


    key = args.activation_key or key
    index = args.index or index
    policy = args.policy or policy
    length = args.otp_length or length
    update = args.auto_update_index or update


    if load_from_s3:
        if not s3_bucket_name:
            sys.stderr.write('S3 mode enabled and s3_bucket_name not provided.\n')
            sys.exit(1)

        # load config from s3
        s3 = boto3.resource('s3')

        try:
            s3.Bucket(s3_bucket_name).download_file(CONFIG_FILE_NAME, CONFIG_FILE)
        except botocore.exceptions.ClientError as e:
            if e.response['Error']['Code'] == "404":
                print("The object does not exist.")
            else:
                raise

        # read config
        Config.read(args.config_file)
        index = Config.getint('MobilePASS', 'index')



    if not key:
        sys.stderr.write('An activation key must be provided.\n')
        sys.exit(1)

    try:
        print (generate_mobilepass_token(key, int(index), policy, int(length)))
    except (InvalidActivationKey, MissingActivationKey) as e:
        sys.stderr.write(e.message + '\n')
        sys.exit(1)

    # Increment the index and save to config if the auto_update_index flag is set
    if update:
        Config.set('MobilePASS', 'index', "{}".format(int(index) + 1))
        cfgfile = open(args.config_file, 'w')
        Config.write(cfgfile)
        cfgfile.close()


    # save to s3
    if load_from_s3:
        s3.meta.client.upload_file(CONFIG_FILE, s3_bucket_name, CONFIG_FILE_NAME)



if __name__ == "__main__":
    main()
