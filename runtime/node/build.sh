#!/bin/bash
set -x
BASE=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
cd "$BASE" || exit 1

# build docker image
VERSION="$(cat $BASE/VERSION)"
IMAGE_NAME="sunzhenkai/node-runtime"
docker build -t $IMAGE_NAME "$BASE" || exit 1
docker tag $IMAGE_NAME $IMAGE_NAME:$VERSION
docker push $IMAGE_NAME:$VERSION
