#!/bin/bash
set -x
BASE=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
cd "$BASE" || exit 1

# build docker image
VERSION="$(cat $BASE/../azkaban-base/assets/VERSION)"
SHORT_VERSION=${VERSION:0:8}
IMAGE_NAME="sunzhenkai/azkaban-executor-server"
docker build --build-arg AZKABAN_BASE_VERSION=$SHORT_VERSION -t $IMAGE_NAME "$BASE" || exit 1
docker tag $IMAGE_NAME $IMAGE_NAME:$SHORT_VERSION
#docker push $IMAGE_NAME:${SHORT_VERSION}
