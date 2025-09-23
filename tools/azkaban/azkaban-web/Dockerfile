ARG AZKABAN_BASE_VERSION=latest
FROM sunzhenkai/azkaban-base:$AZKABAN_BASE_VERSION

WORKDIR /app/azkaban-web-server
ENTRYPOINT [ "sh", "/app/azkaban-web-server/bin/entrypoint_web.sh" ]
EXPOSE 8081
HEALTHCHECK CMD [ "netstat", "-anp", "|", "grep", "8081" ]
