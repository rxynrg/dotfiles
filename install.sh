#!/usr/bin/env bash
set -Eeuo pipefail
set +o posix
if ! command -v ansible >/dev/null 2>&1
then
    pip install ansible
fi
ROOTDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)
ansible-galaxy install -r "$ROOTDIR/requirements.yml"
make run
