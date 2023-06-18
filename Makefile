all: help

install: ## Install the project
	@echo "Installing the project requirements..."
	@ansible-galaxy collection install -r requirements.yml
	@ansible-galaxy role install -r requirements.yml
	@echo "Done!"

setup-monitoring: ## Setup the monitoring
	@echo "Setting up the monitoring..."
	@ansible-playbook playbooks/observium/setup.yml
	@echo "Done!"

setup-monitoring-agent: ## Setup the monitoring agent
	@echo "Setting up the monitoring..."
	@ansible-playbook playbooks/observium_agent/setup.yml
	@echo "Done!"

register-monitoring-agent: ## Setup the monitoring agent
	@echo "Setting up the monitoring..."
	@ansible-playbook playbooks/observium_agent/setup.yml --tags observium_agent:register
	@echo "Done!"

setup-explorer-lthn: ## Setup the explorer
	@echo "Setting up the explorer..."
	@ansible-playbook playbooks/explorer/lthn/setup.yml
	@echo "Done!"

setup-vpn: ## Setup the VPN
	@echo "Setting up the VPN Network..."
	@ansible-playbook playbooks/networking/vpn.yml
	@echo "Done!"

update-vpn: ## Update the VPN Config and Scripts
	@echo "Setting up the VPN Network..."
	@ansible-playbook playbooks/networking/vpn.yml --tags openvpn:bin,openvpn:config
	@echo "Done!"

install-vpn-lite: ## Update the VPN Config and Scripts
	@echo "Setting up the VPN Network..."
	@ansible-playbook playbooks/networking/vpn-lite.yml
	@echo "Done!"

install-miners-xmrig: ## Setup XMRig
	@echo "Setting up xmrig..."
	@ansible-playbook playbooks/miners/xmrig.yml
	@echo "Done!"

setup-chain-lthn: ## Setup Lethean Chain Node
	@echo "Setting up the LTHN chain..."
	@ansible-playbook playbooks/chain/lthn/setup.yml
	@echo "Done!"

setup-chain-lthn-legacy: ## Setup Lethean Legacy Chain Node
	@echo "Setting up the LTHN chain..."
	@ansible-playbook playbooks/chain/lthn-legacy/setup.yml
	@echo "Done!"

install-squid: ## Installs squid
	@echo "Setting up Squid Proxy Server..."
	@ansible-playbook playbooks/networking/squid.yml
	@echo "Done!"

install-keycloak: ## Installs Tyk
	@echo "Setting up KeyCloak Auth Server..."
	@ansible-playbook playbooks/networking/keycloak.yml
	@echo "Done!"

help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m make %-30s\033[0m %s\n", $$1, $$2}'
