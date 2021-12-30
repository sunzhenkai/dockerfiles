.PHONY: all

build:
	@docker build -t sunzhenkai/cmake-external-library .
create:
	@docker run -it -d --sysctl net.core.somaxconn=10240 --name=cmake-external-library sunzhenkai/cmake-external-library
run:
	@docker exec -it cmake-external-library /bin/bash
rmi:
	@docker rmi sunzhenkai/cmake-external-library
stop:
	@docker stop cmake-external-library
rm:
	@docker stop cmake-external-library
	@docker rm cmake-external-library
login:
	@docker login
tag:
	@echo 'input tag: '
	@read version && docker tag sunzhenkai/cmake-external-library:latest sunzhenkai/cmake-external-library:$${version} && docker docker push sunzhenkai/cmake-external-library:$${version}
