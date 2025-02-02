#!/bin/bash

echo -e "\033[1;3;34m--- Worker script starting ---\033[0m"

export DEBIAN_FRONTEND=noninteractive
apt-get update -y && apt-get install -y curl

# Get the master node's IP from the arguments
MASTER_IP=$1

# Get the token from the shared folder
TOKEN=$(cat /vagrant/token)

# Install K3s agent (worker) and join the master node
curl -sfL https://get.k3s.io | K3S_URL=https://$MASTER_IP:6443 K3S_TOKEN=$TOKEN sh -s - agent --token mypassword


echo -e "\033[1;3;34m--- Done ---\033[0m"
