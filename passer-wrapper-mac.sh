#!/bin/bash

CONF_FILE=".mobilepasser.cfg"
CONF_PATH="/home/rd476/"
BUCKET_NAME="passer1"

# Get file from S3
aws s3 cp s3://${BUCKET_NAME}/${CONF_FILE} ${CONF_PATH}/${CONF_FILE}

cat "${CONF_PATH}/${CONF_FILE}"
./mobilepasser/mobilepasser.py | xclip -selection c

aws s3 cp "${CONF_PATH}/${CONF_FILE}" "s3://${BUCKET_NAME}/${CONF_FILE}"
