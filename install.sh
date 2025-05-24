#!/usr/bin/env bash
if ! command -v ansible > /dev/null; then
    command -v pip > /dev/null
    [ "$?" = "1" ] && echo "You need pip to install ansible" && exit 1
    echo "Installing ansible" && pip install ansible
fi
ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)
make sync -C "$ROOT_DIR"
