#!/bin/bash
VERSION="$(cat azkaban-base/assets/VERSION)"
SHORT_VERSION=${VERSION:0:8}

docker push sunzhenkai/azkaban-base/$SHORT_VERSION
docker push sunzhenkai/azkaban-exec-server/$SHORT_VERSION
docker push sunzhenkai/azkaban-web-server/$SHORT_VERSION
