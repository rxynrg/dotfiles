#!/usr/bin/env bash

function mkcd () {
  mkdir -p "$*"
  cd "$*" || return
}

if command -v eza > /dev/null; then
  alias ls="eza --icons"
  alias ll="eza --icons --long --git"
  alias la="eza --icons --long --git --all"
  alias lt="eza --icons --tree"
fi

alias whereami="curl https://ifconfig.co/json"
alias afk="open /System/Library/CoreServices/ScreenSaverEngine.app"
