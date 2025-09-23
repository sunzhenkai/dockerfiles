#!/bin/bash
BASE=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# build docker image
VERSION="$(cat $BASE/assets/VERSION)"
IMAGE_NAME="sunzhenkai/azkaban-base"
docker build -f "$BASE"/Dockerfile --build-arg AZKABAN_VERSION=$VERSION -t $IMAGE_NAME "$BASE" || exit 1
docker tag $IMAGE_NAME $IMAGE_NAME:${VERSION:0:8}
#docker push $IMAGE_NAME:$VERSION
