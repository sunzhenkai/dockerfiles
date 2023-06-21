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
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config

# copy config
COPY env/vim/install-vimrc.sh /tmp/install-vimrc.sh
COPY env/vim/vimrc /root/.vimrc
RUN bash /tmp/install-vimrc.sh

EXPOSE 22
WORKDIR /root
ENTRYPOINT ["/usr/sbin/init"]
