#!/bin/bash
set -euo pipefail

echo -e "\033[1;3;34m=== Init p1 & p2 script starting... ===\033[0m"

sudo apt update && apt upgrade
sudo apt install -y git vim apt-transport-https ca-certificates gnupg

# Install Vagrant
echo -e "\033[1;3;34m=== Install Vagrant ===\033[0m"

wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list > /dev/null

sudo apt update
sudo apt-get install -y vagrant

# Install provider VirtualBox
echo -e "\033[1;3;34m=== Install VirtualBox ===\033[0m"

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle_vbox_2016.gpg] http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
wget -O- -q https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmour -o /usr/share/keyrings/oracle_vbox_2016.gpg

sudo apt update
sudo apt-get install -y virtualbox-7.0
sudo usermod -aG vboxusers $USER

echo -e "\033[1;3;34m=== Cleaning... ===\033[0m"

sudo apt -y clean && sudo apt -y autoremove && sudo apt -y autoclean

echo -e "\033[1;3;34m=== Done! ===\033[0m"
