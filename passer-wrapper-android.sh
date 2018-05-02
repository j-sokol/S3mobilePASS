#!/bin/bash

CONF_FILE=".mobilepasser.cfg"
CONF_PATH="/home/rd476/"
BUCKET_NAME="passer1"
LOG="passer.log"
# Get file from S3
aws s3 cp s3://${BUCKET_NAME}/${CONF_FILE} ${CONF_PATH}/${CONF_FILE} > ${LOG}

cat "${CONF_PATH}/${CONF_FILE}" >/dev/null 

/home/rd476/repos/passer-s3/mobilepasser/mobilepasser.py 


aws s3 cp "${CONF_PATH}/${CONF_FILE}" "s3://${BUCKET_NAME}/${CONF_FILE}" > ${LOG}

