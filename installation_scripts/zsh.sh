#!/usr/bin/env bash

apt update
apt install zsh
chsh -s "$(which zsh)" "$USER"
