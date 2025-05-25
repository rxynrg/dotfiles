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
cp .editorconfig ~

cp common_aliases_and_functions.sh "${XDG_CONFIG_HOME}/common_aliases_and_functions.sh"
cp profile ~/.profile && cp bashrc ~/.bashrc
cp -R zsh "$XDG_CONFIG_HOME" && cp zshenv ~/.zshenv

# TODO: all below

# download fonts ./installation_scripts/fonts.sh
# set up VSCode ./installation_scripts/vsc/configure.sh

## common
### bat
### helix
### eza
### tmux
### fzf
### starship
### zoxide

## dev
### btop
### curlie
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

# ./installation_scripts/docker/install.sh

# brew install go gopls
# brew install zig zls
# sdk/mise install java gradle maven
# brew install kubectl
# brew install colima

# mise use bat eza fzf helix ripgrep starship zoxide
# mise use kotlin
