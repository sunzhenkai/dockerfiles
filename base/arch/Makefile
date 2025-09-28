.PHONY: all

AUTHOR = sunzhenkai
PROJECT = development-arch
CONTAINER_NAME = dev-base-arch
# @env DOCKER_BUILDKIT=1 docker build -t $(AUTHOR)/$(PROJECT) .

build:
	@git submodule update --init
	@docker build -t $(AUTHOR)/$(PROJECT) .
create:
	@docker run -it -d --privileged --sysctl net.core.somaxconn=10240 -p 2022:22 -h deva --name=$(CONTAINER_NAME) $(AUTHOR)/$(PROJECT)
login:
	@docker exec -it $(CONTAINER_NAME) /bin/bash
rmi:
	@docker rmi $(AUTHOR)/$(PROJECT)
stop:
	@docker stop $(CONTAINER_NAME)
rm:
	@docker stop $(CONTAINER_NAME)
	@docker rm $(CONTAINER_NAME)
tag:
	@echo 'input tag: '
	@read version && docker tag $(AUTHOR)/$(PROJECT):latest $(AUTHOR)/$(PROJECT):$${version} && docker push $(AUTHOR)/$(PROJECT):$${version}
logs:
	@docker logs $(CONTAINER_NAME)
