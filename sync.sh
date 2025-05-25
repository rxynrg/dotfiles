#!/usr/bin/env bash

# 1. copy common dotfiles (including aliases, ...)
# 2. copy application specific configurations
# 3. install packages (cli utilities, terminal-based apps)
# 4. install apps (Brewfile or an alternative for mise)

# download fonts ./dotfiles_home/installation_scripts/fonts.sh
# set up VSCode ./dotfiles_home/installation_scripts/vsc/configure.sh
# cp ./dotfiles_home/bashrc $HOME/.bashrc

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

cp -R ./dotfiles_home/bat               ~/.config
cp -R ./dotfiles_home/git               ~/.config
cp -R ./dotfiles_home/helix             ~/.config
cp -R ./dotfiles_home/tmux              ~/.config
cp -R ./dotfiles_home/vim               ~/.config
cp    ./dotfiles_home/starship.toml     ~/.config

cp    ./.editorconfig          ~/.editorconfig

# install docker
# ./dotfiles_home/installation_scripts/docker/install.sh

# brew install go gopls
# brew install zig zls
# sdk/mise install java gradle maven
# brew install kubernetes-cli
# brew install colima
