FROM ubuntu:20.04
LABEL maintainer="zhenkai.sun@qq.com"
SHELL ["/bin/bash", "--login", "-c"]
#COPY assets/sources.list /etc/apt/sources.list
COPY assets/timezone /etc/

RUN apt-get update
RUN apt-get install -y init openssh-server 
RUN apt-get install -y git autoconf automake binutils bison findutils flex gawk \
    gcc-7 g++-7 gettext grep gzip libtool m4 make patch pkgconf sed texinfo python3-pip

RUN ln -fs /usr/bin/gcc-7 /usr/bin/gcc
RUN ln -fs /usr/bin/g++-7 /usr/bin/g++
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
ENV CC=/usr/bin/gcc-7
ENV CXX=/usr/bin/g++7

# config
RUN ssh-keygen -A && mkdir -p /root/.ssh && chmod 0700 /root/.ssh \
    && echo LANG=en_US.UTF-8 > /etc/locale.conf
RUN systemctl enable ssh
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
RUN touch /root/.ssh/authorized_keys && chmod 0644 /root/.ssh/authorized_keys

# ssh port
EXPOSE 22
WORKDIR /root
ENTRYPOINT ["/usr/sbin/init"]