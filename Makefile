THIS_MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
PROJ_ROOT := $(patsubst %/,%,$(dir $(THIS_MAKEFILE_PATH)))

JEKYLL_IMG := jekyll/jekyll
ME := $(shell id -u):$(shell id -g)

.PHONY: all build serve clean
all: build

build:
	docker run --rm --volume="$(PROJ_ROOT):/srv/jekyll" -it $(JEKYLL_IMG) jekyll build

serve:
	@echo "http://localhost:4000/"
	docker run -p 4000:4000 --volume="$(PROJ_ROOT):/srv/jekyll" -it $(JEKYLL_IMG) jekyll serve --watch --incremental --drafts

update-deps:
	docker run --volume="$(PROJ_ROOT):/app" -it ruby:latest bash -c 'cd /app; bundler update --all'

clean:
	rm -rf "$(PROJ_ROOT)/_site/"*
