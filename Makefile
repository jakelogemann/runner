.PHONY: init
init: ## initializes the repository.
	@test -d ./target || mkdir ./target; packer init $(CURDIR)

.PHONY: validate
validate: ## validates the template
	@test -d ./target || mkdir -vp ./target
	packer validate $(CURDIR)

.PHONY: docker
docker: clean validate ## builds the template using docker.
	packer build --only='*.docker.*' $(CURDIR)

.PHONY: docker
digitalocean: clean validate ## builds the template using docker.
	packer build --only='*.digitalocean.*' $(CURDIR)

.PHONY: clean
clean: ## cleans the workspace
	@rm -vrf $(CURDIR)/target/*
