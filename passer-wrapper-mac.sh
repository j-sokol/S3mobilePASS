#!/bin/bash


BASEDIR=$(dirname "$0")


if [ -r $BASEDIR/.passer.rc ]; then
  . $BASEDIR/.passer.rc
fi

# Get config from S3
aws s3 cp s3://${BUCKET_NAME}/${CONF_FILE} ${CONF_PATH}/${CONF_FILE}

# Generate token
python3 $BASEDIR/mobilepasser/mobilepasser.py


# Upload config back to S3
aws s3 cp "${CONF_PATH}/${CONF_FILE}" "s3://${BUCKET_NAME}/${CONF_FILE}"
