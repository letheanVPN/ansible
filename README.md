# Install Ansible & Playbook Requirements
You need to install Ansible on your computer, you can do this by running the following command:

MacOS/Linux: (using Homebrew)
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install ansible
```
Windows: (using Chocolatey) [https://chocolatey.org/](https://chocolatey.org/install#individual)
```
choco install ansible
```


You need to install the requirements for the playbooks to run, you can do this by running the following command:
```
ansible-galaxy collection install -r requirements.yml
ansible-galaxy role install -r requirements.yml
```

## Sign Up For Vultr or any other cloud provider
You need to sign up for a cloud provider, we use Vultr, but you can use any other cloud provider.
You need to add your SSH key to the cloud provider, so you can login to the hosts.

Create VPS instances using Ubuntu 20.04 LTS, you can get them for as low as $6/mo and you should have at least 3 nodes, in separate regions.

- [Vultr - Free $100 credit with our link](https://www.vultr.com/?ref=9034529-8H)

## Configure Ansible Inventory
You need to configure the `hosts` file to include the hosts you want to provision.
An example inventory file is provided in `hosts/hosts.yml`, name yours `01-vultr.yml`, you can add multiple by incrementing the number.
We have a `hosts/*-*.yml` entry in the `.gitignore` so it won't be committed to the repo.

Use the regional layout as demonstrated in the example file, this will allow you to provision hosts in different regions with the correct settings.

## Setup A VPN Network

You need to provision some hosts with the `openvpn` role. You can do this by running the `setup-vpn.yml` playbook. 
This playbook will provision a VPN network to all hosts using the `vpn` group with the following configuration:

- OpenVPN Server
- GlusterFS Network shared storage for client configuration files
- NTP Server for time synchronization using region pool
- Configure UFW firewall to allow OpenVPN traffic and GlusterFS traffic

```shell
make setup-vpn 
```

## Setup a Lethean Blockchain Explorer
Add your hosts to the `hosts/02-explorer.yml` file, you can use the same hosts as the VPN network, or different ones
use the `hosts/explorer.yml` file as a template, make sure you make a new file starting with a number so you can pull updates.

This will provision the host with the following:

- Nginx Web Server
- LetsEncrypt SSL Certificates with automatic renewal
- NodeJS + npm
- Lethean Blockchain Explorer
- UFW Firewall
- Postgres Database
- adds SWAP
- Supervisor to keep the explorer running
```shell
 make setup-explorer 
```