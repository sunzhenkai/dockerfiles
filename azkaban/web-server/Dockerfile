# Doc: https://azkaban.readthedocs.io/en/latest/getStarted.html#installing-azkaban-web-server
FROM openjdk:8 as builder
ARG AZKABAN_VERSION
WORKDIR /src
RUN git clone https://gitee.com/szhenkai/azkaban.git && \
    cd azkaban && \
    git reset --hard ${AZKABAN_VERSION} && \
    git submodule update --init
RUN echo "$PWD"
WORKDIR /src/azkaban/azkaban-web-server
# Fix: Could not GET 'https://nodejs.org/dist/v8.10.0/ivy.xml'. Received status code 403 from server: Forbidden
# See: https://github.com/srs/gradle-node-plugin/issues/292#issuecomment-562848790
RUN sed -i 's/"com.moowork.node" version "1.2.0"/("com.github.node-gradle.node") version "2.2.0"/g' build.gradle && \
    ../gradlew build installDist -x test

FROM amazoncorretto:8-alpine-jre
ENV MYSQL_HOST=host.docker.internal
ENV AZKABAN_MYSQL_USERNAME=azkaban
ENV AZKABAN_MYSQL_PASSWORD=azkaban
# npm registry for china mainland
RUN echo "registry=https://registry.npmmirror.com/" > /root/.npmrc

WORKDIR /app/azkaban-web-server
COPY --from=builder /src/azkaban/azkaban-web-server/build/install/azkaban-web-server .
ENTRYPOINT [ "/app/azkaban-web-server/bin/start-web.sh" ]
EXPOSE 8081
HEALTHCHECK CMD [ "netstat", "-anp", "|", "grep", "8081" ]