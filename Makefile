REGISTRY = https://index.docker.io/v1/
NAME = reportbook-docs
IMAGE = jimdo/$(NAME)
WL = ./wl

clean:
	rm -rf site

pull:
	docker pull golang:alpine
	docker pull python:2.7

site: clean pull
	docker run --rm -v $(CURDIR):/src --entrypoint=/bin/bash python:2.7 /src/build.sh

preview: pull
	docker run --rm -ti -v $(CURDIR):/src -p 3000:3000 --entrypoint=/bin/bash python:2.7 /src/build.sh preview

build: site
	docker build -t $(IMAGE) .

push: build
	docker login -u="$(DOCKER_USERNAME)" -p="$(DOCKER_PASSWORD)" $(REGISTRY)
	docker push $(IMAGE)

deploy: push $(WL)
	$(WL) deploy --watch $(NAME)

$(WL):
	curl -sSo $(WL) https://downloads.jimdo-platform.net/wl/latest/wl_latest_$(shell uname -s | tr A-Z a-z)_$(shell uname -m | sed "s/x86_64/amd64/")
	chmod +x $(WL)
	$(WL) version