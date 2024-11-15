#!/usr/bin/env bash

function mkcd () {
  mkdir -p "$*"
  cd "$*" || return
}

if command -v eza > /dev/null; then
  alias ls="eza --icons"
  alias ll="eza --long"
  alias la="eza --long --all"
  alias lt="eza --icons --tree"
fi

alias afk="open /System/Library/CoreServices/ScreenSaverEngine.app"
alias uuid_to_clipboard="uuidgen | tr '[:upper:]' '[:lower:]' | pbcopy"
alias whereami="curl https://ifconfig.co/json"
