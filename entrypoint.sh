#!/bin/sh -l

QBEE_FILE_SRC="$INPUT_SOURCE"
QBEE_FILE_DST="$INPUT_DESTINATION"

if [ "x$QBEE_FILE_SRC" = "x" ]; then
    QBEE_FILE_SRC="$INPUT_LOCAL_DIRECTORY/$INPUT_FILENAME"
fi

if [ "x$QBEE_FILE_DST" = "x" ]; then
    QBEE_FILE_DST="$INPUT_QBEE_DIRECTORY"
fi

qbee-cli files upload --source "$QBEE_FILE_SRC" --destination "$QBEE_FILE_DST" --overwrite
