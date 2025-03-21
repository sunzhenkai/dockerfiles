.PHONY: all
NAME=dev-gcc13

build:
	@docker build -t sunzhenkai/${NAME} .
create:
	@docker run -it -d --privileged --sysctl net.core.somaxconn=10240 --name=${NAME} sunzhenkai/${NAME}
run:
	@docker exec -it ${NAME} /bin/bash
rmi:
	@docker rmi sunzhenkai/${NAME}
stop:
	@docker stop ${NAME}
rm:
	@docker stop ${NAME}
	@docker rm ${NAME}
login:
	@docker login
tag:
	@echo 'input tag: '
	@read version && docker tag sunzhenkai/${NAME}:latest sunzhenkai/${NAME}:$${version} && docker docker push sunzhenkai/${NAME}:$${version}
