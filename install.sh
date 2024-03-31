#!/usr/bin/env bash
if ! command -v ansible > /dev/null; then
    echo "Installing ansible"
    pip install ansible
fi
ROOTDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)
make sync -C "$ROOTDIR"
