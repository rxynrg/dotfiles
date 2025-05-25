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
cp profile ~/.profile
cp bashrc ~/.bashrc
#cp -R zsh "$XDG_CONFIG_HOME"
#cp zshrc ~/.zshrc

# TODO: all below

# install packages (cli utilities, terminal-based apps)
# install apps (Brewfile or an alternative for mise)

# download fonts ./dotfiles_home/installation_scripts/fonts.sh
# set up VSCode ./dotfiles_home/installation_scripts/vsc/configure.sh

# were installed with brew
## common
### - bat
### - helix
### - eza
### - tmux
### - fzf
### - starship
### - zoxide

## dev
### - btop
### - curlie
### - duf
### - gnupg
### - gping
### - htmlq
### - direnv
### - grpcurl
### - jq
### - jless
### - lazygit
### - mkcert # https://github.com/FiloSottile/mkcert see PiterJS #50 on youtube
### - step
### - websocat
### - yq

## home
### - cloudflare-warp
### - ghostty
### - intellij-idea
### - obsidian
### - rectangle
### - telegram
### - tor-browser
### - visual-studio-code
### - vlc
### - wireshark
### - zed

# ./dotfiles_home/installation_scripts/docker/install.sh

# brew install go gopls
# brew install zig zls
# sdk/mise install java gradle maven
# brew install kubernetes-cli
# brew install colima
