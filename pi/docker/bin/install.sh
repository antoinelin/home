#!/bin/bash

# This script is meant to be run on a Raspberry Pi 4 running Rasp. OS 64-bit.
# It will install Docker and Docker Compose.
# As installation requires a reboot, this script will reboot the Pi after installation.

DIR="$( cd "$( dirname "$0" )" && pwd )"

cd $DIR
cd ..

# Add Docker's official GPG key:
sudo apt update
sudo apt install install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable docker

# Add user to docker group
sudo usermod -aG docker $USER

shutdown --reboot 1 "System rebooting in 1 minute"
sleep 90