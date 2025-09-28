# FROM manjarolinux/base:20250504
FROM archlinux:multilib-devel-20250921.0.423275
LABEL maintainer="zhenkai.sun@qq.com"
SHELL ["/bin/bash", "--login", "-c"]

# install packages
RUN sudo pacman -Syy
RUN pacman -S --noconfirm --needed vi vim neovim openssl openssh make cmake git ripgrep base-devel

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
