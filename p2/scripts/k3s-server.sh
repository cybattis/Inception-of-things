#!/bin/bash
set -euo pipefail

echo -e "\033[1;3;34m=== Server script starting ===\033[0m"

export DEBIAN_FRONTEND=noninteractive # Prevent stdin error
MASTER_IP=$1 # Get the master node's IP from the arguments

apt-get update -y && apt-get install -y curl

echo -e "\033[1;32m=== Installing K3s ===\033[0m"

export INSTALL_K3S_EXEC="--node-external-ip=$MASTER_IP --flannel-iface=eth1 --write-kubeconfig-mode=644"
# Install K3s on the master node
curl -sfL https://get.k3s.io | sh -s -

# # Wait for the server to start
# sleep 5

# # Get and store the token for the worker nodes
# sudo cat /var/lib/rancher/k3s/server/node-token > /vagrant/token

echo -e "\033[1;3;34m--- Done ---\033[0m"
