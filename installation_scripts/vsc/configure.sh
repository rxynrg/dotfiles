#!/usr/bin/env bash

vsc_settings_home=$( [[ "$(uname)" == "Darwin" ]] && echo "$HOME/Library/Application Support/Code/User/settings.json" || echo "$HOME/.config/Code/User/settings.json" )
mkdir -p "$vsc_settings_home"
cp "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/settings.jsonc" "$vsc_settings_home/settings.json"

extensions=(
    "drcika.apc-extension"
    "editorconfig.editorconfig"
#    "github.github-vscode-theme"
#    "marlosirapuan.nord-deep"
#    "ms-vscode-remote.remote-containers"
#    "ms-vscode-remote.remote-ssh"
#    "ms-vscode-remote.remote-ssh-edit"
#    "ms-vscode.remote-explorer"
    "timonwong.shellcheck"
)

for ext in "${extensions[@]}"; do
    code --install-extension "$ext"
done
