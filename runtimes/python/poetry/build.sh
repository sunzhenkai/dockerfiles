#!/bin/bash
set -e
BASE=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
IMAGE_NAME=runtime/python-poetry
REPO=registry.cn-hangzhou.aliyuncs.com
VERSION="$(cat $BASE/VERSION)"

# Build
docker build -f runtimes/python/poetry/Dockerfile -t ${IMAGE_NAME}:latest $BASE
# Push
docker tag ${IMAGE_NAME}:latest ${REPO}/${IMAGE_NAME}:$VERSION
docker push ${REPO}/${IMAGE_NAME}:$VERSION
