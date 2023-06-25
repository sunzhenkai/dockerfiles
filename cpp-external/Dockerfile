FROM ubuntu:22.04
LABEL maintainer="zhenkai.sun@qq.com"
LABEL version="v0.0.1"
SHELL ["/bin/bash", "--login", "-c"]
WORKDIR /root

# install packages
RUN apt update && apt install -y openssh-server git g++ gcc wget make pkg-config
# cmake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.26.4/cmake-3.26.4-linux-x86_64.sh \
    && chmod a+x cmake-3.26.4-linux-x86_64.sh \
    && bash cmake-3.26.4-linux-x86_64.sh --skip-license --prefix=/usr
RUN git clone https://github.com/sunzhenkai/cmake-external-targets.git && mkdir cmake-external-targets/build
WORKDIR /root/cmake-external-targets
RUN make install-dependencies
WORKDIR /root/cmake-external-targets/build
RUN cmake .. -DCMAKE_C_COMPILER=/usr/bin/cc -DCMAKE_CXX_COMPILER=/usr/bin/g++ && make -j

# ssh config
RUN mkdir /root/.ssh && ssh-keygen -A && chmod 0700 /root/.ssh \
    && echo LANG=en_US.UTF-8 > /etc/locale.conf
RUN systemctl enable ssh
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
RUN touch /root/.ssh/authorized_keys && chmod 0644 /root/.ssh/authorized_keys
EXPOSE 22

ENTRYPOINT ["/usr/sbin/init"]
