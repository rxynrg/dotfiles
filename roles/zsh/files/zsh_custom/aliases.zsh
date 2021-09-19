# mkdir, cd into it (via http://onethingwell.org/post/586977440/mkcd-improved)
function mkcd () {
    mkdir -p "$*"
    cd "$*" || return
}

alias dis="docker images --format \"{{.ID}}\t{{.Size}}\t{{.Repository}}\" | sort -hk2"

drm() {
  docker rmi "$(docker images -f 'dangling=true' | awk '{if ($1 == "<none>") {print $3 } ')"
}

alias ls="exa --icons --git"
alias la="ls --all"
alias ll="ls --long"
alias lla="ll --all"
alias tree="ls --tree"
