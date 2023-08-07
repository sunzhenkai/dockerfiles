# Doc: https://azkaban.readthedocs.io/en/latest/getStarted.html#installing-azkaban-web-server
FROM openjdk:8 as builder
ARG AZKABAN_VERSION
WORKDIR /src
RUN git clone https://gitee.com/szhenkai/azkaban.git && cd azkaban && git reset --hard ${AZKABAN_VERSION} && git submodule update --init
WORKDIR /src/azkaban/azkaban-web-server
# npm registry for china mainland
RUN echo "registry=https://registry.npmmirror.com/" > /root/.npmrc
# Fix: Could not GET 'https://nodejs.org/dist/v8.10.0/ivy.xml'. Received status code 403 from server: Forbidden
# See: https://github.com/srs/gradle-node-plugin/issues/292#issuecomment-562848790
RUN sed -i 's/"com.moowork.node" version "1.2.0"/("com.github.node-gradle.node") version "2.2.0"/g' build.gradle && \
    # sed -i 's/org.apache.commons:commons-dbcp2:2.7.0/org.apache.commons:commons-dbcp2:2.9.0/g' build.gradle && \
    # sed -i 's/mysql:mysql-connector-java:8.0.20/mysql:mysql-connector-java:8.0.33/g' build.gradle && \
    ../gradlew build installDist -x test
# WORKDIR /src/azkaban/azkaban-db
# RUN ../gradlew build installDist

FROM apache/hadoop:3 as hadoop

FROM amazoncorretto:8-alpine-jre
RUN apk update && apk add mariadb-client
WORKDIR /app/azkaban-web-server
COPY --from=builder /src/azkaban/azkaban-web-server/build/install/azkaban-web-server .
# COPY --from=builder /src/azkaban/azkaban-db/build/distributions/azkaban-db-0.1.0-SNAPSHOT.tar.gz .
COPY --from=hadoop /opt/hadoop /app/hadoop
COPY entrypoint.sh /app/azkaban-web-server/bin/
ENV HADOOP_HOME=/app/hadoop
RUN sed -i 's/${script_dir}/sh ${script_dir}/g' bin/start-web.sh
RUN sed -i 's/echo "Using Hadoop from $HADOOP_HOME"/echo "Using Hadoop from $HADOOP_HOME"\nCLASSPATH=${CLASSPATH}:${HADOOP_HOME}\/share\/hadoop\/client\/*:${HADOOP_HOME}\/share\/hadoop\/mapreduce\/*:${HADOOP_HOME}\/share\/hadoop\/hdfs\/*:${HADOOP_HOME}\/share\/hadoop\/common\/lib\/*:${HADOOP_HOME}\/share\/hadoop\/yarn\/lib\/*/g' bin/internal/internal-start-web.sh
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories
ENTRYPOINT [ "sh", "/app/azkaban-web-server/bin/entrypoint.sh" ]
EXPOSE 8081
HEALTHCHECK CMD [ "netstat", "-anp", "|", "grep", "8081" ]