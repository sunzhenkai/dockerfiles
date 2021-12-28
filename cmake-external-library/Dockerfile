FROM centos:7.9.2009
LABEL maintainer="zhenkai.sun@qq.com"
LABEL version="centos7-v0.0.1"
RUN yum update -y && \
    yum install -y centos-release-scl && \
    yum install -y devtoolset-9 && \
    yum install -y rh-python38 && \
    source /opt/rh/rh-python38/enable && \
    yum install -y epel-release && \
    yum install -y cmake3 && \
    ln -s /usr/bin/cmake3 /usr/bin/cmake && \
    yum install -y flex bison wget automake autoconf make git libtool ninja-build && \
    echo "source /opt/rh/devtoolset-9/enable" >> /etc/bashrc

SHELL ["/bin/bash", "--login", "-c"]
RUN printf "unset BASH_ENV PROMPT_COMMAND ENV\nsource scl_source enable devtoolset-9 rh-python38\n" > /usr/bin/scl_enable
ENV BASH_ENV="/usr/bin/scl_enable" \
    ENV="/usr/bin/scl_enable" \
    PROMPT_COMMAND=". /usr/bin/scl_enable"