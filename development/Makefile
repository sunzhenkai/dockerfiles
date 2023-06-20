.PHONY: all

build:
	@docker build -t sunzhenkai/development .
create:
	@docker run -it -d --sysctl net.core.somaxconn=10240 --name=development sunzhenkai/development
run:
	@docker exec -it development /bin/bash
rmi:
	@docker rmi sunzhenkai/development
stop:
	@docker stop development
rm:
	@docker stop development
	@docker rm development
login:
	@docker login
tag:
	@echo 'input tag: '
	@read version && docker tag sunzhenkai/development:latest sunzhenkai/development:$${version} && docker docker push sunzhenkai/development:$${version}
