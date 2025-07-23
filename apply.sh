#!/usr/bin/env bash

# https://wiki.archlinux.org/title/XDG_Base_Directory
XDG_CONFIG_HOME="$HOME/.config"
mkdir -p "$XDG_CONFIG_HOME" "$HOME/.cache" "$HOME/.data" "$HOME/.data/state" 2>/dev/null || true

cp -R bat   "$XDG_CONFIG_HOME"
cp -R git   "$XDG_CONFIG_HOME"
cp -R helix "$XDG_CONFIG_HOME"
cp -R tmux  "$XDG_CONFIG_HOME"
cp -R vim   "$XDG_CONFIG_HOME"
cp starship.toml "$XDG_CONFIG_HOME"
cp .editorconfig "$HOME"

cp common_aliases_and_functions.sh "${XDG_CONFIG_HOME}/common_aliases_and_functions.sh"
cp profile "$HOME/.profile" && cp bashrc "$HOME/.bashrc"
cp -R zsh "$XDG_CONFIG_HOME" && cp zshenv "$HOME/.zshenv" && mkdir -p "${XDG_CONFIG_HOME}/zsh/completions"

# TODO: all below

## dev
### btop
### curlie
### dive
### duf
### gping
### htmlq
### direnv
### grpcurl
### jq
### jless
### lazygit
### mkcert # https://github.com/FiloSottile/mkcert see PiterJS #50 on youtube
### step
### websocat
### yq

# mise install bat eza fzf helix ripgrep starship zoxide

# mise install go
# mise install zig zls
# mise install java gradle maven kotlin
# mise install colima # macos only
# mise install kubectl
# mise install kind
