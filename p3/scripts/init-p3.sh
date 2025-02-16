#!/bin/bash
set -euo pipefail

echo -e "\033[1;3;34m=== Init p3 script starting ===\033[0m"

apt-get install net-tools curl -y

echo -e "\033[1;3;34m=== Install docker ===\033[0m"
# Add Docker's official GPG key:
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

usermod -aG docker $USER

echo -e "\033[1;3;34m=== Install kublect ===\033[0m"
# Download latest release
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
# Install kubectl
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
rm $SCRIPTPATH/kubectl

echo -e "\033[1;3;34m=== Install K3d ===\033[0m"
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

echo -e "\033[1;3;34m=== Install argocd ===\033[0m"

curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

echo -e "\033[1;3;34m=== Cleaning... ===\033[0m"
apt -y clean && apt -y autoremove && apt -y autoclean

echo -e "\033[1;3;34m=== Done ===\033[0m"
