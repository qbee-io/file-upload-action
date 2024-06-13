#!/bin/sh

#inputs
filename=$2
qbee_directory=$3
local_directory=$4
run=$5
api_host=$6

if [[ -n "$api_host" ]]; then
  echo "WARNING: api_host is deprecated, this is handled in the authentication action"
fi

if [[ -n "$run" ]]; then
  echo "WARNING: run is deprecated."
fi

qbee-cli files upload --source "$local_directory/$filename" --destination "$qbee_directory" --overwrite
