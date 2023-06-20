.PHONY: all

AUTHOR = sunzhenkai
PROJECT = development
CONTAINER_NAME = dev-base

test:
	@echo $(AUTHOR)
build:
	@docker build -t $(AUTHOR)/$(PROJECT) .
create:
	@docker run -it -d --sysctl net.core.somaxconn=10240 --name=$(CONTAINER_NAME) $(AUTHOR)/$(PROJECT)
login:
	@docker exec -it $(CONTAINER_NAME) /bin/bash
remove-image:
	@docker rmi $(AUTHOR)/$(PROJECT)
stop:
	@docker stop $(CONTAINER_NAME)
rm:
	@docker stop $(CONTAINER_NAME)
	@docker rm $(CONTAINER_NAME)
tag:
	@echo 'input tag: '
	@read version && docker tag $(AUTHOR)/$(PROJECT):latest $(AUTHOR)/$(PROJECT):$${version} && docker docker push $(AUTHOR)/$(PROJECT):$${version}
