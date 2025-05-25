#!/usr/bin/env bash

apt-get update && apt-get instsall ca-certificates
# prepare keyrings
install -m 0755 -d /etc/apt/keyrings
# download docker's official GPG key
curl -sSLo /etc/apt/keyrings/docker.asc https://download.docker.com/linux/ubuntu/gpg
# update permissions
chmod +r /etc/apt/keyrings/docker.asc

echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

apt-get update && apt-get install \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-compose-plugin \
    docker-compose-buildx
