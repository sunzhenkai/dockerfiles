FROM manjarolinux/base:20230618
LABEL maintainer="zhenkai.sun@qq.com"
LABEL version="v0.0.1"
SHELL ["/bin/bash", "--login", "-c"]

# install packages
RUN pacman-mirrors --geoip && sudo pacman -Syyu \
    && pacman -S --noconfirm --needed vim openssh make cmake git emacs ripgrep base-devel pamac-cli

# spacemacs
RUN git clone https://github.com/syl20bnr/spacemacs $HOME/.emacs.d

# config
RUN ssh-keygen -A && chmod 0700 /root/.ssh \
    && echo LANG=en_US.UTF-8 > /etc/locale.conf
RUN systemctl enable sshd

# copy config
COPY config/vimrc /root/.vimrc

EXPOSE 22:2022
WORKDIR /root
ENTRYPOINT ["/usr/sbin/init"]
