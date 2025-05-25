#!/usr/bin/env bash

if [[ "$(uname)" == "Darwin" ]]; then
    "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/macos.sh"
elif [[ $(. /etc/os-release && echo "$ID_LIKE") == "debian" ]]; then
    "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/debian.sh"
fi
