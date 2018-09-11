#!/bin/bash


BASEDIR=$(dirname "$0")


if [ -r $BASEDIR/.passer.rc ]; then
  . $BASEDIR/.passer.rc
fi


# Get config from S3
aws s3 cp s3://${BUCKET_NAME}/${CONF_FILE} ${CONF_PATH}/${CONF_FILE} > ${LOG}

# Generate token
echo -n `$BASEDIR/mobilepasser/mobilepasser.py | xsel -b -i
#| xvkbd -xsendevent -file - 2>/dev/null`

# Save token to the clipboard
xdotool sleep 0.5 key --clearmodifiers "ctrl+v"; > ${LOG}

# Upload config back to S3
aws s3 cp "${CONF_PATH}/${CONF_FILE}" "s3://${BUCKET_NAME}/${CONF_FILE}" > ${LOG}
