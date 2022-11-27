SHELL := /bin/bash -eu -o pipefail -c
ROOT_DIR ?= $(shell git rev-parse --show-toplevel)
YAML_FILES ?= $(shell find . -name '*.y*ml')

# docker command with security options
DOCKER_RUN ?= docker run $(DOCKER_OPTIONS)
DOCKER_OPTIONS ?= -it --rm -v $(ROOT_DIR):/work -w /work
DOCKER_OPTIONS += --user 1111:1111 --read-only --cap-drop all
DOCKER_OPTIONS += --security-opt no-new-privileges --network none

# docker run
ACTIONLINT ?= $(DOCKER_RUN) rhysd/actionlint:latest
PRETTIER ?= $(DOCKER_RUN) ghcr.io/tmknom/dockerfiles/prettier:latest
YAMLLINT ?= $(DOCKER_RUN) ghcr.io/tmknom/dockerfiles/yamllint:latest
ACTDOCS ?= $(DOCKER_RUN) ghcr.io/tmknom/actdocs:latest

.PHONY: lint
lint: ## lint
	$(YAMLLINT) --strict --config-file ".yamllint.yml" .
	$(ACTIONLINT) -color
	$(PRETTIER) --check --parser=yaml $(YAML_FILES)

.PHONY: fmt
fmt: ## format code
	$(PRETTIER) --write --parser=yaml $(YAML_FILES)

.PHONY: docs
docs: ## generate document
	$(ACTDOCS) inject --sort --file=README.md action.yml

.PHONY: release
release: ## release new version
	@select LEBEL in 'patch' 'minor' 'major'; do \
	  case "$${LEBEL}" in \
	    'patch') gh workflow run release.yml -f level=patch; break ;; \
	    'minor') gh workflow run release.yml -f level=minor; break ;; \
	    'major') gh workflow run release.yml -f level=major; break ;; \
	    *) echo 'Error: invalid parameter'; exit 1 ;; \
	  esac; \
	done

.DEFAULT_GOAL := help
.PHONY: help
help: ## show help
	@grep --no-filename -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
