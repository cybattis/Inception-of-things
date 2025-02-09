#!/bin/bash
set -euo pipefail

echo -e "\033[1;3;34m=== Server script starting ===\033[0m"

export DEBIAN_FRONTEND=noninteractive # Prevent stdin error

apt-get update -y && apt-get install -y curl

echo -e "\033[1;32m=== Installing K3s ===\033[0m"

# Install K3s on the master node
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -s -

# Ajouter l'autocomplétion à votre profil Bash
echo "source <(kubectl completion bash)" >> ~/.bashrc
sleep 2

echo -e "\033[1;3;34m--- K3s installed ---\033[0m"
echo -e "\033[1;3;34m--- Installing pods... ---\033[0m"

sudo kubectl apply -f /vagrant/confs/app1.yaml
sudo kubectl apply -f /vagrant/confs/app2.yaml
sudo kubectl apply -f /vagrant/confs/app3.yaml
sudo kubectl apply -f /vagrant/confs/ingress.yaml

echo -e "\033[1;3;34m--- Done ---\033[0m"
