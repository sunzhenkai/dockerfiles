build:
	@bash scripts/build.sh $(name) $(tag)

create:
	@docker run -it -d --name=$(name)-$(tag) sunzhenkai/$(name):$(tag)

delete:
	@docker stop $(name)-$(tag)
	@docker rm $(name)-$(tag)

login:
	@docker exec -it $(name)-$(tag) /bin/bash

push:
	@docker push sunzhenkai/$(name):$(tag)
