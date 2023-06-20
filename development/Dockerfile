FROM manjarolinux/base:20230618
LABEL maintainer="zhenkai.sun@qq.com"
LABEL version="v0.0.1"
SHELL ["/bin/bash", "--login", "-c"]

RUN pacman-mirrors --geoip && sudo pacman -Syyu \
    && pacman -S --noconfirm --needed vim openssh

RUN ssh-keygen -A && chmod 0700 /root/.ssh

COPY config/vimrc /root/.vimrc

EXPOSE 22
WORKDIR /root
CMD ["/usr/sbin/sshd", "-D", "-e"]