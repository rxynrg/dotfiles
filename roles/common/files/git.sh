#!/usr/bin/env bash

alias g="git"

if command -v fzf > /dev/null; then
  gli() {
    # param validation
    if [[ ! $(git log -n 1 "$@" | head -n 1) ]]; then
      return
    fi
    # filter by file string
    local filter
    # param existed, git log for file if existed
    if [ -n "$*" ] && [ -f "$*" ]; then
      filter="-- $*"
    fi
    # git command
    local gitlog=(
      git log
      --graph --color=always
      --abbrev=7
      --format='%C(auto)%h%d %an %C(blue)%s %C(yellow)%C(bold)%cr'
      "$@"
    )
    # fzf command
    local fzf=(
      fzf
      --ansi --no-sort --reverse --tiebreak=index
      --preview "bat --color=always --style=numbers --line-range=:500 {}"
      --preview "f() { set -- \$(echo -- \$@ | grep -o '[a-f0-9]\{7\}'); [ \$# -eq 0 ] || git show --color=always \$1 $filter; }; f {}"
      --bind "ctrl-q:abort,ctrl-m:execute:
                  (grep -o '[a-f0-9]\{7\}' | head -1 |
                  xargs -I % sh -c 'git show --color=always % $filter | less -R') << 'FZF-EOF'
                  {}
                  FZF-EOF"
      --preview-window=right:60%
    )
    # piping them
    "${gitlog[@]}" | "${fzf[@]}"
  }
fi

# Takes in PAT as an argument
git_update_pat() {
  # TODO: read from stdin
  token=$1
  if [[ "$token" = ghp_* ]]; then
    repo_url=$(git remote get-url origin)
    credentials="${token}@"
    new_remote="${repo_url/https:\/\//https://$credentials}"
    git remote set-url origin "$new_remote"
  else
    echo "Invalid token '$token'. Please provide GH PAT as positional argument"
  fi
}
