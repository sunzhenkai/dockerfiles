FROM ubuntu:22.04
LABEL maintainer="zhenkai.sun@qq.com"
SHELL ["/bin/bash", "--login", "-c"]
#COPY assets/sources.list /etc/apt/sources.list
COPY assets/timezone /etc/

RUN apt-get update
RUN apt-get install -y git autoconf automake binutils bison findutils flex gawk \
    gcc-10 g++-10 gettext grep gzip libtool m4 make patch pkgconf sed texinfo python3-pip \
    gdb wget curl vim  

# cmake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.26.4/cmake-3.26.4-linux-x86_64.sh \
    && chmod a+x cmake-3.26.4-linux-x86_64.sh \
    && bash cmake-3.26.4-linux-x86_64.sh --skip-license --prefix=/usr

RUN ln -fs /usr/bin/gcc-10 /usr/bin/gcc
RUN ln -fs /usr/bin/g++-10 /usr/bin/g++
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
ENV CC=/usr/bin/gcc-10
ENV CXX=/usr/bin/g++10

WORKDIR /root
ENTRYPOINT ["/usr/bin/sh"]