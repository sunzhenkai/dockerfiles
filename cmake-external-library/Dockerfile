FROM	centos:7 AS env
LABEL	maintainer="zhenkai.sun@qq.com"
LABEL   version="centos7-v0.0.1"
RUN     yum update -y
RUN     yum install -y centos-release-scl
RUN     yum install -y devtoolset-9
RUN     yum -y install wget automake autoconf make cmake git libtool
RUN     echo "source /opt/rh/devtoolset-9/enable" >> /etc/bashrc
SHELL   ["/bin/bash", "--login", "-c"]
RUN     gcc --version