.PHONY: all

build:
	@docker build -t sunzhenkai/cmake-external-library .
create:
	@docker run -it -d --name=cmake-external-library sunzhenkai/cmake-external-library
run:
	@docker exec -it cmake-external-library /bin/bash
rmi:
	@docker rmi sunzhenkai/cmake-external-library
stop:
	@docker stop cmake-external-library
rm:
	@docker stop cmake-external-library
	@docker rm cmake-external-library