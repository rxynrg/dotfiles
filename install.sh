#!/usr/bin/env bash

while [[ $# -gt 0 ]]; do
    case "$1" in
        docker) installation_scripts/docker/install.sh ;;
        vscode) installation_scripts/vsc/configure.sh ;;
        fonts) installation_scripts/fonts.sh ;;
        zsh) installation_scripts/zsh.sh ;;
        *) echo "error: unexpected $1";;
    esac
    shift
done
