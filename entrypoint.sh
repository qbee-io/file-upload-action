#!/bin/sh

#inputs
filename=$1
qbee_directory=$2
local_directory=$3
run=$4
api_host=$5

if [[ -n "$api_host" ]]; then
  echo "WARNING: api_host is deprecated, this is handled in the authentication action"
fi

if [[ -n "$run" ]]; then
  echo "WARNING: run is deprecated."
fi

qbee-cli files upload --source "$local_directory/$filename" --destination "$qbee_directory" --overwrite
