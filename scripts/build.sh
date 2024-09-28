#!/bin/bash
IMAGE_NAME=$1
IMAGE_TAG=$2

[ -z "$IMAGE_NAME" ] && echo "[ERROR] no image name" && exit 1
[ -z "$IMAGE_TAG" ] && echo "[ERROR] no image tag" && exit 1

REPO_URL_PREFIX="sunzhenkai"

docker build -t "${REPO_URL_PREFIX}/${IMAGE_NAME}:${IMAGE_TAG}" "$IMAGE_NAME"
