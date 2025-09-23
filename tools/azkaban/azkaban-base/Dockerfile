# Doc: https://azkaban.readthedocs.io/en/latest/getStarted.html#installing-azkaban-web-server
FROM openjdk:8 AS builder
# build azkaban
WORKDIR /build
COPY assets/compile.sh .
COPY assets/VERSION .
RUN bash compile.sh

FROM apache/hadoop:3 AS hadoop
FROM amazoncorretto:8-alpine-jre
RUN apk --no-cache add curl mysql-client

# hadoop
COPY --from=hadoop /opt/hadoop /app/hadoop
ENV HADOOP_HOME=/app/hadoop
ENV HADOOP_INSTALL=$HADOOP_HOME
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME
ENV HADOOP_COMMON_HOME=$HADOOP_HOME
ENV HADOOP_HDFS_HOME=$HADOOP_HOME
ENV YARN_HOME=$HADOOP_HOME
ENV HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
ENV PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
ENV HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"

COPY --from=builder /azkaban /app
WORKDIR /app
COPY assets/patch.sh .
RUN sh patch.sh
COPY assets/entrypoint_exec.sh /app/azkaban-exec-server/bin/
COPY assets/entrypoint_web.sh /app/azkaban-web-server/bin/
