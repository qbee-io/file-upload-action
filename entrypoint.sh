#!/bin/sh -l

#inputs
filename=$1
qbee_directory=$2
local_directory=$3

qbee-cli files upload --source "$local_directory/$filename" --destination "$qbee_directory" --overwrite
