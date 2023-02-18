.DEFAULT_GOAL := help
ROOT:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

DOCS_PATH=test
MKDOCS:=docker run -it --rm -p 8082:8000 --name mkdocs-test -v ${DOCS_PATH}:/src -w /src -u $(id -u ${USER}):$(id -g ${USER}) smulas/mkdocs mkdocs

help: ## Display this help message
	@echo
	@printf $(HGREEN)=$(BLUE)-------------------------------------------------$(HGREEN)=$(NOCOLOR)"\n"
	@printf $(HGREEN)="                       ASM                       "=$(NOCOLOR)"\n"
	@printf $(HGREEN)="                  "$(CYAN)"Version: "$(NOCOLOR)${CUR_VER}"                 "$(HGREEN)=$(NOCOLOR)"\n"
	@printf $(HGREEN)=$(BLUE)-------------------------------------------------$(HGREEN)=$(NOCOLOR)"\n"
	@echo
	@printf $(LYELLOW)"Please use \`make <target>\` where <target> is one of\n\n"$(NOCOLOR)
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf $(GREEN)"%-25s"$(NOCOLOR)"%s\n", $$1, $$2}' | sed -e "s/\[32m##/[36m/"

.PHONY: help

##
## Build Commands
##

serve: ## serve test website
	@echo running on http://localhost:8082
	docker run -it --rm \
	-p 8082:8000 \
	--name mkdocs-test \
	-v ${ROOT}/test:/src \
	-w /src \
	-u $(id -u ${USER}):$(id -g ${USER}) \
	smulas/mkdocs mkdocs serve -a 0.0.0.0:8000

build: ## build docker image
	docker build -t smulas/mkdocs .         

deploy: ## deploy docker image to dockerhub
	docker push smulas/mkdocs  