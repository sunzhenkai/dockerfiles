FROM ubuntu:24.04
LABEL maintainer="zhenkai.sun@qq.com"
SHELL ["/bin/bash", "--login", "-c"]
COPY timezone /etc/

# install packages
RUN apt update
RUN apt install -y init vim openssl openssh-server make cmake git python3-pip

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
