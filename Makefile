.DEFAULT_GOAL := help

.PHONY: help
help: ## Print Makefile help.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: install-hooks
install-hooks: ## Install git hooks.
	pip3 install --user --upgrade pre-commit
	pre-commit install -f --install-hooks

.PHONY: requirements
requirements: .requirements ## Install pipenv environment
.requirements:
	pipenv install
	touch .requirements

.PHONY: deploy
deploy: requirements ## Deploy site to the default target
	pipenv run lektor deploy ${TARGET}

.PHONY: deploy-github
deploy-github: TARGET = github
deploy-github: deploy ## Publish site to github

.PHONY: serve
serve: requirements ## Serve lektor locally
	pipenv run lektor serve
