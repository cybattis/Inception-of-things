#!/bin/bash
set -euo pipefail

echo -e "\033[1;3;34m=== Init p3 script starting ===\033[0m"

sudo apt-get install net-tools -y

echo -e "\033[1;3;34m=== Install docker ===\033[0m"
# Add Docker's official GPG key:
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo -e "\033[1;3;34m=== Install kublect ===\033[0m"
# Download latest release
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
# Install kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

echo -e "\033[1;3;34m=== Install K3d ===\033[0m"
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

echo -e "\033[1;3;34m=== Cleaning... ===\033[0m"
sudo apt -y clean && sudo apt -y autoremove && sudo apt -y autoclean

echo -e "\033[1;3;34m=== Done ===\033[0m"
