#!/bin/sh -l

QBEE_FILE_SRC="$INPUT_SOURCE"
QBEE_FILE_DST="$INPUT_DESTINATION"

if [ "x$QBEE_FILE_SRC" = "x" ]; then
    QBEE_FILE_SRC="$INPUT_LOCAL_DIRECTORY/$INPUT_FILENAME"
fi

if [ "x$QBEE_FILE_DST" = "x" ]; then
    QBEE_FILE_DST="$INPUT_QBEE_DIRECTORY"
fi

if [ "x$INPUT_ACTION" = "xupload" ]; then
    qbee-cli files upload --source "$QBEE_FILE_SRC" --destination "$QBEE_FILE_DST" --overwrite
    INPUT_ACTION="upload"
elif [ "x$INPUT_ACTION" = "xsync" ]; then
    qbee-cli files sync --source "$QBEE_FILE_SRC" --destination "$QBEE_FILE_DST" --delete
else
    echo "Invalid action: $INPUT_ACTION"
    exit 1
fi