#!/bin/bash
set -e
BASE=$(echo "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)")
#mkdir /src && mkdir /src
azkaban_version=$(cat VERSION)

function CompileAzkaban() {
  [[ -e azkaban ]] && rm -r azkaban
  git clone https://github.com/azkaban/azkaban.git
  cd azkaban
  git reset --hard ${azkaban_version} && git submodule update --init

  # npm registry for china mainland
  # run echo "registry=https://registry.npmmirror.com/" > /root/.npmrc
  # fix: could not get 'https://nodejs.org/dist/v8.10.0/ivy.xml'. received status code 403 from server: forbidden
  # see: https://github.com/srs/gradle-node-plugin/issues/292#issuecomment-562848790
  sed -i 's/"com.moowork.node" version "1.2.0"/("com.github.node-gradle.node") version "2.2.0"/g' azkaban-web-server/build.gradle
  # sed -i 's/org.apache.commons:commons-dbcp2:2.7.0/org.apache.commons:commons-dbcp2:2.9.0/g' build.gradle && \
  # sed -i 's/mysql:mysql-connector-java:8.0.20/mysql:mysql-connector-java:8.0.33/g' build.gradle && \
  ./gradlew build installdist -x test
}

function CopyFiles() {
  [[ -e /azkaban ]] && rm -r /azkaban
  mkdir /azkaban
  # copy azkaban exec server
  cp -r azkaban-exec-server/build/install/azkaban-exec-server /azkaban/
  cp -r azkaban-web-server/build/install/azkaban-web-server /azkaban/
  cp -r azkaban-db/build/install/azkaban-db /azkaban/
}

CompileAzkaban
CopyFiles
