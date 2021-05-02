function idea() {
  open -na IntelliJ\ IDEA.app --args "$@"
}

# mkdir, cd into it (via http://onethingwell.org/post/586977440/mkcd-improved)
function mkcd () {
    mkdir -p "$*"
    cd "$*" || return
}

# tree
alias tree1="tree -L 1"
alias tree1h="tree -L 1 -h"
alias tree2="tree -L 2"
alias tree2h="tree -L 2 -h"
alias tree3="tree -L 3"
alias tree3h="tree -L 3 -h"

# k8s
alias k="kubectl"
alias kaf="kubectl apply -f"
alias kcgc="kubectl config get-contexts"
alias kgp="kubectl get pods"
alias kgpa="kubectl get pods --all-namespaces"
alias kgpl="kgp -l"
alias kgpn="kgp -n"
alias kgi="kubectl get ingress"
alias kgns="kubectl get namespaces"
alias kgcm="kubectl get configmaps"
alias kgd="kubectl get deployment"
alias kga="kubectl get all"
alias kgaa="kubectl get all --all-namespaces"
alias kl="kubectl logs"
alias kgno="kubectl get nodes"

alias g="git"

alias dis="docker images --format \"{{.ID}}\t{{.Size}}\t{{.Repository}}\" | sort -hk2"

drm() {
  docker rmi "$(docker images -f 'dangling=true' | awk '{if ($1 == "<none>") {print $3 } ')"
}

gli() {
  # param validation
  if [[ ! $(git log -n 1 "$@" | head -n 1) ]] ;then
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
