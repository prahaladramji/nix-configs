.PHONY: help

help: ## show help messages.
	@echo 'usage: make [target]'
	@echo
	@echo 'targets:'
	@egrep '^(.+)\:\ ##\ (.+)' $(MAKEFILE_LIST) | column -t -c 2 -s ':#'

build: ## builds the changes only.
	@nix build --no-link

activate: ## activate the previously created build.
	@$$(nix path-info)/activate

clean: ## delete previous generations.
	@nix-env --delete-generations old

clean-all: clean ## garbage collect nix store and clean all previous generations.
	@nix-store --gc
	@nix-collect-garbage -d
