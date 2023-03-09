all: help

install: ## Install the project
	@echo "Installing the project requirements..."
	@ansible-galaxy collection install -r requirements.yml
	@ansible-galaxy role install -r requirements.yml
	@echo "Done!"

setup-explorer: ## Setup the explorer
	@echo "Setting up the explorer..."
	@ansible-playbook playbooks/explorer/setup.yml
	@echo "Done!"

setup-vpn: ## Setup the VPN
	@echo "Setting up the VPN..."
	@ansible-playbook setup-vpn.yml
	@echo "Done!"

help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m make %-30s\033[0m %s\n", $$1, $$2}'
