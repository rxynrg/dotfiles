#!/usr/bin/env bash

sudo apt-get update && sudo apt-get install -y ca-certificates curl
# prepare Docker keyring directory
sudo install -m 0755 -d /etc/apt/keyrings
# download Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo tee /etc/apt/keyrings/docker.asc >/dev/null
# update key file permissions
sudo chmod a+r /etc/apt/keyrings/docker.asc

# add Docker's APT repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

sudo apt-get update && apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-compose-plugin \
    docker-buildx-plugin
