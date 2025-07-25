#!/usr/bin/env bash

# https://wiki.archlinux.org/title/XDG_Base_Directory
XDG_CONFIG_HOME="$HOME/.config"
mkdir -p "$XDG_CONFIG_HOME" "$HOME/.cache" "$HOME/.data" "$HOME/.data/state" 2>/dev/null || true

cp -R bat   "$XDG_CONFIG_HOME"
cp -R git   "$XDG_CONFIG_HOME"
cp -R helix "$XDG_CONFIG_HOME"
cp -R tmux  "$XDG_CONFIG_HOME"
cp -R vim   "$XDG_CONFIG_HOME"
cp -R yazi  "$XDG_CONFIG_HOME"
cp starship.toml "$XDG_CONFIG_HOME"
cp .editorconfig "$HOME"

cp shell_independent_aliases_and_functions.sh "${XDG_CONFIG_HOME}/shell_independent_aliases_and_functions.sh"
cp profile "$HOME/.profile" && cp bashrc "$HOME/.bashrc"
cp -R zsh "$XDG_CONFIG_HOME" && cp zshenv "$HOME/.zshenv"

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
### jless (depends on X11 lib, so consider stop using this)
### lazygit
### mkcert # https://github.com/FiloSottile/mkcert see PiterJS #50 on youtube
### ripgrep
### step
### websocat
### yq

# mise install bat eza fzf helix starship yazi zoxide

# mise install go
# mise install zig zls
# mise install java gradle maven kotlin
# mise install colima # macos only (consider native containers)
# mise install kind kubectl

# Casks
# cloudflare-warp
# ghostty
# intellij-idea
# obsidian
# rectangle
# telegram
# tor-browser
# vlc
# wireshark
# zed
