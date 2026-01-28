.PHONY: help install setup clean defaults

help: ## Show this help message
	@echo "Usage: make [target]"
	@echo ""
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

setup: ## Install and configure all dependencies for a new machine
	@./scripts/setup.sh

install: ## Install dependencies using Homebrew
	@./scripts/install.sh

clean: ## Clean up temporary files
	@echo "Cleaning up..."
	@find . -name "*.swp" -delete
	@find . -name "*~" -delete
	@echo "Clean complete."

stow: ## Symlink dotfiles to home directory
	@./scripts/stow.sh

unstow: ## Remove symlinks from home directory
	@./scripts/unstow.sh

defaults: ## Configure macOS system defaults
	@./scripts/macos-defaults.sh
