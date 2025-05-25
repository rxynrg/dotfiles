#!/usr/bin/env bash

if [[ "$(uname)" == "Darwin" ]]; then
    ./dotfiles_home/installation_scripts/docker/macos.sh
elif [[ $(. /etc/os-release && echo "$ID_LIKE") == "debian" ]]; then
    ./dotfiles_home/installation_scripts/docker/debian.sh
fi
