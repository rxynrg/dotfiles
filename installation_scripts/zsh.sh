#!/usr/bin/env bash

! [[ "$(getent passwd "$USER" | cut -d: -f7)" == "/usr/bin/zsh" ]] && {
    sudo apt update
    sudo apt install -y zsh
    chsh -s "$(which zsh)" "$USER"
}
true
