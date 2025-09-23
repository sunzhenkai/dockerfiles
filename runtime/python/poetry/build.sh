#!/bin/bash
set -e
BASE=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# defines
IMAGE_NAME=sunzhenkai/runtime-python-poetry
REPO=registry.cn-hangzhou.aliyuncs.com
VERSION="$(cat $BASE/VERSION)"

# build
docker build -f runtime/python/poetry/Dockerfile -t ${IMAGE_NAME}:latest $BASE
# push
docker tag ${IMAGE_NAME}:latest ${REPO}/${IMAGE_NAME}:$VERSION
docker push ${REPO}/${IMAGE_NAME}:$VERSION
