FROM ubuntu:22.04
LABEL maintainer="zhenkai.sun@qq.com"
SHELL ["/bin/bash", "--login", "-c"]
COPY sources.list /etc/apt/sources.list
COPY timezone /etc/

# install packages
RUN apt update
RUN apt install -y init vim openssl openssh-server make cmake git emacs python3-pip

# pip packages
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip install jupyter numpy pandas seaborn matplotlib scipy scikit-learn

## spacemacs
# RUN git clone https://github.com/syl20bnr/spacemacs $HOME/.emacs.d

## vim
# COPY env/vim/install-vimrc.sh /tmp/install-vimrc.sh
# COPY env/vim/vimrc /root/.vimrc
# RUN bash /tmp/install-vimrc.sh

## jupyter
RUN mkdir -p /data/jupyter/notebooks
COPY config/jupyter.service /etc/systemd/system/
COPY config/jupyter_server_config.json /data/jupyter/
RUN systemctl enable jupyter

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
# jupyter server port
EXPOSE 8085
WORKDIR /root
ENTRYPOINT ["/usr/sbin/init"]
