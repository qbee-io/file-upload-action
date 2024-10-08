#!/bin/sh -l

QBEE_FILE_SRC="$INPUT_SOURCE"
QBEE_FILE_DST="$INPUT_DESTINATION"

if [ "x$QBEE_FILE_SRC" = "x" ]; then
    QBEE_FILE_SRC="$INPUT_LOCAL_DIRECTORY/$INPUT_FILENAME"
fi

if [ "x$QBEE_FILE_DST" = "x" ]; then
    QBEE_FILE_DST="$INPUT_QBEE_DIRECTORY"
fi

QBEE_CLI_OPTIONS=""
if [ "x$INPUT_ACTION" = "xupload" ]; then
    QBEE_CLI_OPTIONS="$QBEE_CLI_OPTIONS --overwrite"
elif [ "x$INPUT_ACTION" = "xsync" ]; then
    QBEE_CLI_OPTIONS="$QBEE_CLI_OPTIONS --delete"
else
    echo "Invalid action: $INPUT_ACTION"
    exit 1
fi

if [ "x$INPUT_EXCLUDE" != "x" ] && [ "x$INPUT_ACTION" = "xsync" ]; then
    QBEE_CLI_OPTIONS="$QBEE_CLI_OPTIONS --exclude $INPUT_EXCLUDE"
fi

if [ "x$INPUT_INCLUDE" != "x" ] && [ "x$INPUT_ACTION" = "xsync" ]; then
    QBEE_CLI_OPTIONS="$QBEE_CLI_OPTIONS --include $INPUT_INCLUDE"
fi

#shellcheck disable=SC2086
qbee-cli files "$INPUT_ACTION" --source "$QBEE_FILE_SRC" --destination "$QBEE_FILE_DST" $QBEE_CLI_OPTIONS
