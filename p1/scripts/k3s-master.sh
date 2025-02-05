#!/bin/bash

echo -e "\033[1;3;34m === Server script starting ===\033[0m"

apt-get update -y && apt-get install -y curl

echo -e "\033[1;32m=== Installing K3s ===\033[0m"

export INSTALL_K3S_EXEC="--bind-address=$SERVER_IP --node-external-ip=$SERVER_IP --flannel-iface=eth1 --write-kubeconfig-mode=644"
# Install K3s on the master node
curl -sfL https://get.k3s.io | sh -s -

# Get the token for the worker nodes
TOKEN=$(sudo cat /var/lib/rancher/k3s/server/node-token)

# Store the token for the workers to use
echo $TOKEN > /vagrant/token

echo -e "\033[1;3;34m--- Done ---\033[0m"
