FROM manjarolinux/base:20250504
LABEL maintainer="zhenkai.sun@qq.com"
SHELL ["/bin/bash", "--login", "-c"]

# install packages
RUN pacman-mirrors --geoip 
RUN sudo pacman -Syy
RUN pacman -S --noconfirm --needed vim openssl openssh make cmake git emacs \
  ripgrep base-devel pamac-cli python3-pip

# pip packages
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

## spacemacs
# RUN git clone https://github.com/syl20bnr/spacemacs $HOME/.emacs.d

## jupyter
RUN mkdir -p /data/jupyter/notebooks
COPY config/jupyter.service /etc/systemd/system/
COPY config/jupyter_notebook_config.py /data/jupyter/
RUN systemctl enable jupyter

# config
RUN ssh-keygen -A && chmod 0700 /root/.ssh \
  && echo LANG=en_US.UTF-8 > /etc/locale.conf
RUN systemctl enable sshd
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
RUN touch /root/.ssh/authorized_keys && chmod 0644 /root/.ssh/authorized_keys

EXPOSE 22
EXPOSE 8085
WORKDIR /root
ENTRYPOINT ["/usr/sbin/init"]
