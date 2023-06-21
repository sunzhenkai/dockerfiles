FROM manjarolinux/base:20230618
LABEL maintainer="zhenkai.sun@qq.com"
LABEL version="v0.0.1"
SHELL ["/bin/bash", "--login", "-c"]

# install packages
RUN pacman-mirrors --geoip && sudo pacman -Syyu \
    && pacman -S --noconfirm --needed vim openssh make cmake git emacs ripgrep base-devel pamac-cli

# spacemacs
RUN git clone https://github.com/syl20bnr/spacemacs $HOME/.emacs.d
# vim
COPY env/vim/install-vimrc.sh /tmp/install-vimrc.sh
COPY env/vim/vimrc /root/.vimrc
RUN bash /tmp/install-vimrc.sh

# config
RUN ssh-keygen -A && chmod 0700 /root/.ssh \
    && echo LANG=en_US.UTF-8 > /etc/locale.conf
RUN systemctl enable sshd
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
RUN touch /root/.ssh/authorized_keys && chmod 0644 /root/.ssh/authorized_keys

EXPOSE 22
WORKDIR /root
ENTRYPOINT ["/usr/sbin/init"]
