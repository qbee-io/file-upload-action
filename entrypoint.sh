#!/bin/sh -l

QBEE_FILE_SRC="$INPUT_SOURCE"
QBEE_FILE_DST="$INPUT_DESTINATION"

if [ "x$QBEE_FILE_SRC" = "x" ]; then
    QBEE_FILE_SRC="$INPUT_LOCAL_DIRECTORY/$INPUT_FILENAME"
fi

if [ "x$QBEE_FILE_DST" = "x" ]; then
    QBEE_FILE_DST="$INPUT_QBEE_DIRECTORY"
fi

# Build the argument list with positional parameters so every value is passed
# as a single quoted argument. This avoids word splitting, glob expansion and
# argument injection from user-controlled inputs such as exclude/include.
set -- files "$INPUT_ACTION" --source "$QBEE_FILE_SRC" --destination "$QBEE_FILE_DST"

if [ "x$INPUT_ACTION" = "xupload" ]; then
    set -- "$@" --overwrite
elif [ "x$INPUT_ACTION" = "xsync" ]; then
    set -- "$@" --delete
else
    echo "Invalid action: $INPUT_ACTION"
    exit 1
fi

if [ "x$INPUT_EXCLUDE" != "x" ] && [ "x$INPUT_ACTION" = "xsync" ]; then
    set -- "$@" --exclude "$INPUT_EXCLUDE"
fi

if [ "x$INPUT_INCLUDE" != "x" ] && [ "x$INPUT_ACTION" = "xsync" ]; then
    set -- "$@" --include "$INPUT_INCLUDE"
fi

qbee-cli "$@"
