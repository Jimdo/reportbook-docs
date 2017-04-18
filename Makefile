clean:
	rm -rf site

pull:
	docker pull golang:alpine
	docker pull python:2.7

site: clean pull
	docker run --rm -v $(CURDIR):/src --entrypoint=/bin/bash python:2.7 /src/build.sh

preview: pull
	docker run --rm -ti -v $(CURDIR):/src -p 3000:3000 --entrypoint=/bin/bash python:2.7 /src/build.sh preview
