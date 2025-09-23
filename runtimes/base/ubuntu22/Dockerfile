FROM ubuntu:22.04
COPY sources.list /etc/apt/sources.list
COPY timezone /etc/
RUN apt update \
    && apt install -y init wget git curl xz-utils make 
ENTRYPOINT ["/bin/bash"]