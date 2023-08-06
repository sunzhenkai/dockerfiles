#!/bin/sh

script_dir=$(dirname $0)

# [ port file not exist ] or [ request failure ]
while [ $(ls ${script_dir}/../executor.port > /dev/null 2>&1; echo $?) -ne 0 ] || \
    # https://azkaban.readthedocs.io/en/latest/getStarted.html#installing-azkaban-executor-server
    [ $(curl -G "localhost:$(cat ${script_dir}/../executor.port)/executor?action=activate" > /dev/null 2>&1; echo $?) -ne 0 ]
do
    sleep 1
done