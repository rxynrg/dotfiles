# mkdir, cd into it (via http://onethingwell.org/post/586977440/mkcd-improved)
function mkcd () {
  mkdir -p "$*"
  cd "$*" || return
}

if command -v eza > /dev/null; then
  alias ls="eza --icons --git"
  alias ll="eza --icons --git --long"
  alias la="eza --icons --git --long --all"
  alias lt="eza --icons --git --tree"
fi

function whereami () {
  curl https://ifconfig.co/json
}
