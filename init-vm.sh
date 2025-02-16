#!/usr/bin/bash

sudo apt update && apt upgrade

sudo apt install -y git vim

# See instructions at https://developer.hashicorp.com/vagrant/downloads
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update
sudo apt-get install -y vagrant

# Install provider VirtualBox
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle_vbox_2016.gpg] http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
wget -O- -q https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmour -o /usr/share/keyrings/oracle_vbox_2016.gpg

sudo apt update
sudo apt-get install -y virtualbox-7.0
sudo usermod -aG vboxusers $USER

sudo apt -y clean && sudo apt -y autoremove && sudo apt -y autoclean
