FROM ubuntu:24.04
LABEL maintainer="zhenkai.sun@qq.com"
SHELL ["/bin/bash", "--login", "-c"]
ARG VCPKG_ROOT=/root/vcpkg
ARG GCC_VERSION=13
COPY assets/timezone /etc/

RUN apt-get update
RUN apt-get install -y git autoconf automake binutils bison findutils flex gawk \
    gcc-$GCC_VERSION g++-$GCC_VERSION gettext grep gzip libtool m4 make patch pkgconf sed texinfo python3-pip \
    gdb wget curl vim zip unzip tar xz-utils

# cmake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.26.4/cmake-3.26.4-linux-x86_64.sh \
    && chmod a+x cmake-3.26.4-linux-x86_64.sh \
    && bash cmake-3.26.4-linux-x86_64.sh --skip-license --prefix=/usr

# vcpkg
ENV VCPKG_ROOT=$VCPKG_ROOT
RUN git clone https://github.com/Microsoft/vcpkg.git "$VCPKG_ROOT" && bash "$VCPKG_ROOT/bootstrap-vcpkg.sh"

RUN ln -fs /usr/bin/gcc-$GCC_VERSION /usr/bin/gcc
RUN ln -fs /usr/bin/g++-$GCC_VERSION /usr/bin/g++
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
ENV CC=/usr/bin/gcc-$GCC_VERSION
ENV CXX=/usr/bin/g++$GCC_VERSION

WORKDIR /root
ENTRYPOINT ["/usr/bin/sh"]
