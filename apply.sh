#!/usr/bin/env bash

XDG_CONFIG_HOME="$HOME/.config"
mkdir -p "$XDG_CONFIG_HOME" "$HOME/.cache" "$HOME/.local/share" "$HOME/.local/state" "$HOME/.local/bin" 2>/dev/null || true

cp -R bat   "$XDG_CONFIG_HOME"
cp -R git   "$XDG_CONFIG_HOME"
cp -R helix "$XDG_CONFIG_HOME"
cp -R tmux  "$XDG_CONFIG_HOME"
cp -R yazi  "$XDG_CONFIG_HOME"
cp starship.toml "$XDG_CONFIG_HOME"
cp .editorconfig "$HOME"
cp .vimrc        "$HOME"

cp shell_independent_aliases_and_functions.sh "${XDG_CONFIG_HOME}/shell_independent_aliases_and_functions.sh"
cp profile "$HOME/.profile" && cp bashrc "$HOME/.bashrc"
cp -R zsh "$XDG_CONFIG_HOME" && cp zshenv "$HOME/.zshenv"

# == DEV
### btop
### curlie
### dive
### duf
### glow
### gping
### grpcurl
### jq
### lazygit
### mkcert      # https://github.com/FiloSottile/mkcert see PiterJS #50 on youtube
### ripgrep
### step
### sqlite
### websocat
### yq

# mise install bat eza fzf helix starship yazi zoxide
# mise install ollama opencode pi

# mise install go
# mise install zig zls
# mise install java gradle maven kotlin

# mise install colima
# mise install kind kubectl

# == Casks
# ghostty
# intellij-idea
# obsidian
# rectangle
# telegram
# tor-browser
# vlc
# wireshark
# zed
