#!/bin/bash


BASEDIR=$(dirname "$0")


if [ -r $BASEDIR/.passer.rc ]; then
  . $BASEDIR/.passer.rc
fi

# Get file from S3
aws s3 cp s3://${BUCKET_NAME}/${CONF_FILE} ${CONF_PATH}/${CONF_FILE} > ${LOG}

cat "${CONF_PATH}/${CONF_FILE}" >/dev/null 

$BASEDIR/mobilepasser/mobilepasser.py

aws s3 cp "${CONF_PATH}/${CONF_FILE}" "s3://${BUCKET_NAME}/${CONF_FILE}" > ${LOG}
