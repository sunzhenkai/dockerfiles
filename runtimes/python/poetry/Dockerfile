FROM ubuntu:24.04
COPY sources.list /etc/apt/sources.list
COPY timezone /etc/
RUN apt-get update
RUN apt-get install -y curl python3 python3-pip python3-venv libmysqlclient-dev python3-socks vim iputils-ping telnet pkg-config
RUN curl -sSL https://install.python-poetry.org | python3 -
RUN pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

ENV PATH="/root/.local/bin:$PATH"
