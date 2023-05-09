# mkdir, cd into it (via http://onethingwell.org/post/586977440/mkcd-improved)
function mkcd () {
  mkdir -p "$*"
  cd "$*" || return
}

if command -v exa >/dev/null; then
  alias ls="exa --icons --git"
  alias ll="exa --icons --git --long"
  alias la="exa --icons --git --long --all"
  alias lt="exa --icons --git --tree"
fi

function whereami () {
  curl https://ifconfig.co/json
}
