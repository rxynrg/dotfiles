#!/usr/bin/env bash
set -Eeuo pipefail
set +o posix
if ! command -v ansible >/dev/null 2>&1
then
    pip install ansible
fi
ansible-galaxy install -r requirements.yml
make run
