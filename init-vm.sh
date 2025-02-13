#!/usr/bin/bash

sudo apt update && apt upgrade

sudo apt install -y git vim

# See instructions at https://developer.hashicorp.com/vagrant/downloads
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list

# Install provider VirtualBox
apt-get install -y virtualbox