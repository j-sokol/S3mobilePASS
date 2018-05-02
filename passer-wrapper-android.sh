#!/bin/bash

CONF_FILE=".mobilepasser.cfg"
CONF_PATH="/data/data/com.termux/files/home/"
BUCKET_NAME="passer1"
LOG="passer.log"
# Get file from S3
aws s3 cp s3://${BUCKET_NAME}/${CONF_FILE} ${CONF_PATH}/${CONF_FILE} > ${LOG}

cat "${CONF_PATH}/${CONF_FILE}" >/dev/null 

/data/data/com.termux/files/home/mobilePASSer/mobilepasser/mobilepasser.py 


aws s3 cp "${CONF_PATH}/${CONF_FILE}" "s3://${BUCKET_NAME}/${CONF_FILE}" > ${LOG}

