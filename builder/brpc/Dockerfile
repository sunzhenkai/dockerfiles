FROM ubuntu:24.04

WORKDIR /app
RUN apt update
RUN apt install -y git g++ make libssl-dev libgflags-dev libprotobuf-dev libprotoc-dev protobuf-compiler libleveldb-dev cmake
RUN git clone https://github.com/apache/brpc.git
WORKDIR /app/brpc
RUN cmake -B build -DBUILD_BRPC_TOOLS=ON && cmake --build build -j

