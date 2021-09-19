# mkdir, cd into it (via http://onethingwell.org/post/586977440/mkcd-improved)
function mkcd () {
    mkdir -p "$*"
    cd "$*" || return
}

alias ls="exa --icons --git"
alias la="ls --all"
alias ll="ls --long"
alias lla="ll --all"
alias tree="ls --tree"
