.PONEY: build

build:
	@#docker build -t brpc:master .
	@docker create --name brpc-tmp brpc:master 
	@docker cp brpc-tmp:/app/brpc/build/output .
	@docker rm brpc-tmp
