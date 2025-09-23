FROM ubuntu:24.04

# 设置时区
COPY timezone /etc/

# 安装依赖并清理缓存
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        python3 \
        python3-pip \
        python3-venv \
        libmysqlclient-dev \
        python3-socks \
        vim \
        iputils-ping \
        telnet \
        pkg-config && \
    # 清理apt缓存以减小镜像体积
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    # 安装poetry
    curl -sSL https://install.python-poetry.org | python3 - && \
    # 设置pip源为清华镜像
    pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# 设置poetry路径
ENV PATH="/root/.local/bin:$PATH"
