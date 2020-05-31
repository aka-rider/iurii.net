THIS_MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
PROJ_ROOT := $(patsubst %/,%,$(dir $(THIS_MAKEFILE_PATH)))
DOCKER_IMG := "iurii.net"
JEKYLL_IMG := "jekyll/jekyll:stable"

.PHONY: all build serve clean $(DOCKER_IMG)
all: build

# build: $(DOCKER_IMG)
# 	$(shell \
# 		ID=`docker create -it $(DOCKER_IMG) jekyll build`; \
# 		docker cp "$${ID}:/srv/jekyll/_site/." "$(PROJ_ROOT)/_site")


build:
	docker run --rm --volume="$(PROJ_ROOT):/srv/jekyll" -it $(JEKYLL_IMG) jekyll build

serve: $(DOCKER_IMG)
	@echo "http://localhost:4000/"
	#docker run -p 4000:4000 -it $(DOCKER_IMG) jekyll serve --watch --incremental --drafts
	docker run -p 4000:4000 --volume="$(PROJ_ROOT):/srv/jekyll" -it $(DOCKER_IMG) jekyll serve --watch --incremental --drafts

$(DOCKER_IMG):
	docker build -t $(DOCKER_IMG) .

clean:
	rm -rf "$(PROJ_ROOT)/_site/"*
