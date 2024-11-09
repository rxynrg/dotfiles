#!/usr/bin/env bash

function mkcd () {
  mkdir -p "$*"
  cd "$*" || return
}

if command -v eza > /dev/null; then
  alias ls="eza"
  alias ll="eza --long"
  alias la="eza --long --all"
  alias lt="eza --icons --tree"
fi

alias afk="open /System/Library/CoreServices/ScreenSaverEngine.app"
alias ghtoken="cat ~/.env | grep GH_TOKEN | cut -d '=' -f 2 | pbcopy"
alias uuidboard="uuidgen | tr '[:upper:]' '[:lower:]' | pbcopy"
alias whereami="curl https://ifconfig.co/json"
