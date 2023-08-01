FROM sunzhenkai/base-runtime:0.0.3
WORKDIR /tmp
RUN mkdir /app/ && \
    wget https://nodejs.org/dist/v18.17.0/node-v18.17.0-linux-x64.tar.xz && \
    tar -xf node-v18.17.0-linux-x64.tar.xz -C /app/
ENV PATH="/app/node-v18.17.0-linux-x64/bin:${PATH}"
ENTRYPOINT ["/usr/sbin/init"]