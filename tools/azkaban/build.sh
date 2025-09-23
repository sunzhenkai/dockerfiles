#!/bin/bash
pushd azkaban-base
bash build.sh
popd

pushd azkaban-exec
bash build.sh
popd

pushd azkaban-web
bash build.sh
popd
