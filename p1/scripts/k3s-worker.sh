#!/bin/bash
set -euo pipefail

echo -e "\033[1;3;34m=== Worker script starting ===\033[0m"

export DEBIAN_FRONTEND=noninteractive # Prevent stdin error
MASTER_IP=$1 # Get the master node's IP from the arguments

apt-get update -y && apt-get install -y curl

# Get the token from the shared folder
TOKEN=$(cat /vagrant/token)

# Install K3s agent (worker) and join the master node
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--flannel-iface=eth1" \
	K3S_URL=https://$MASTER_IP:6443 K3S_TOKEN=$TOKEN \
	sh -s -

echo -e "\033[1;3;34m=== Done ===\033[0m"
