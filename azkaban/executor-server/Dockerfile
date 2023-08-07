# Doc: https://azkaban.readthedocs.io/en/latest/getStarted.html#installing-azkaban-exec-server
# build binary
FROM openjdk:8 as builder
ARG AZKABAN_VERSION
WORKDIR /src
RUN git clone https://gitee.com/szhenkai/azkaban.git && cd azkaban && git reset --hard ${AZKABAN_VERSION} && git submodule update --init
WORKDIR /src/azkaban/azkaban-exec-server
# Fix: Could not GET 'https://nodejs.org/dist/v8.10.0/ivy.xml'. Received status code 403 from server: Forbidden
# See: https://github.com/srs/gradle-node-plugin/issues/292#issuecomment-562848790
RUN sed -i 's/"com.moowork.node" version "1.2.0"/("com.github.node-gradle.node") version "2.2.0"/g' build.gradle && \
    ../gradlew build installDist -x test
WORKDIR /src/azkaban/azkaban-db
RUN ../gradlew build installDist

FROM apache/hadoop:3 as hadoop
# build image
FROM amazoncorretto:8-alpine-jre
WORKDIR /app/azkaban-exec-server
# Doc: https://www.cyberciti.biz/faq/how-to-install-curl-on-alpine-linux/
RUN apk --no-cache add curl mysql-client
COPY --from=builder /src/azkaban/azkaban-exec-server/build/install/azkaban-exec-server .
COPY --from=builder /src/azkaban/azkaban-db/build/distributions/azkaban-db-0.1.0-SNAPSHOT.tar.gz .
COPY --from=hadoop /opt/hadoop /app/hadoop
ENV HADOOP_HOME=/app/hadoop
RUN sed -i 's/echo "Using Hadoop from $HADOOP_HOME"/echo "Using Hadoop from $HADOOP_HOME"\nCLASSPATH=${CLASSPATH}:${HADOOP_HOME}\/share\/hadoop\/client\/*:${HADOOP_HOME}\/share\/hadoop\/mapreduce\/*:${HADOOP_HOME}\/share\/hadoop\/hdfs\/*:${HADOOP_HOME}\/share\/hadoop\/common\/lib\/*:${HADOOP_HOME}\/share\/hadoop\/yarn\/lib\/*/g' bin/internal/internal-start-executor.sh
COPY entrypoint.sh bin
RUN sed -i 's/${script_dir}/sh ${script_dir}/g' bin/start-exec.sh

ENTRYPOINT [ "sh", "bin/entrypoint.sh" ]
EXPOSE 12321
HEALTHCHECK CMD [ "curl", "-G", "localhost:12321/executor?action=activate" ]