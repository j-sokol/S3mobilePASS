#!/bin/bash

CONF_FILE=".mobilepasser.cfg"
CONF_PATH="/home/rd476/"
BUCKET_NAME="passer1"
LOG="/var/log/passer.log"
# Get file from S3
aws s3 cp s3://${BUCKET_NAME}/${CONF_FILE} ${CONF_PATH}/${CONF_FILE} > ${LOG}

cat "${CONF_PATH}/${CONF_FILE}" >/dev/null 

echo -n `/home/rd476/repos/passer-s3/mobilepasser/mobilepasser.py | xsel -b -i
#| xvkbd -xsendevent -file - 2>/dev/null`

xdotool sleep 0.5 key --clearmodifiers "ctrl+v"; > ${LOG}

aws s3 cp "${CONF_PATH}/${CONF_FILE}" "s3://${BUCKET_NAME}/${CONF_FILE}" > ${LOG}
