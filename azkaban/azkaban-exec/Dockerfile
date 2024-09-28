ARG AZKABAN_BASE_VERSION=latest
FROM sunzhenkai/azkaban-base:$AZKABAN_BASE_VERSION

WORKDIR /app/azkaban-exec-server
ENTRYPOINT [ "sh", "bin/entrypoint_exec.sh" ]
EXPOSE 12321
HEALTHCHECK CMD [ "curl", "-G", "127.0.0.1:12321/executor?action=activate" ]
