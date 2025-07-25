########## GENERAL
alias cp='cp -v'
alias ln='ln -v'
alias mv='mv -v'
alias afk="open /System/Library/CoreServices/ScreenSaverEngine.app"
alias uuid="uuidgen | tr '[:upper:]' '[:lower:]'"
alias whereami="curl https://ifconfig.co/json"
alias java_print_all="java -XX:+UnlockDiagnosticVMOptions -XX:+UnlockExperimentalVMOptions -XX:+PrintFlagsFinal -XX:+EnableJVMCI -XX:+JVMCIPrintProperties --version"
alias y='yazi'

if command -v eza >/dev/null; then
    alias ls="eza --icons --group-directories-first"
    alias ll="eza --long --group-directories-first"
    alias la="eza --long --all --group-directories-first"
    alias lt="eza --icons --tree"
else
    alias ls='ls -h --color=auto'
    alias ll='ls -al'
fi

mkcd() {
    mkdir -p "$1"
    cd "$1" || return
}

########## GIT
alias g='git'
alias rr='cd $(git rev-parse --show-toplevel)' # go to repo root
gli() {
    # param validation
    [[ ! $(git log -n 1 "$@" | head -n 1) ]] && return
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

########## DOCKER
alias vmgo='colima start --mount $(dirname $(pwd)):w'

alias d='docker'
alias dis="docker images --format \"{{.ID}}\t{{.Size}}\t{{.Repository}}\" | sort -hk2"
alias docker-rmi-force='docker rmi -f $(docker images -a -q)'
alias docker-rmc-force='docker ps -q | xargs docker rm -f'
alias docker-rmc="docker ps -a --filter=status=exited --format='{{ .ID }}' | xargs docker rm"

drm() {
    docker rmi "$(docker images -f 'dangling=true' \
        | awk '$1 == "<none>" { print $3 }' ORS=' ')"
}

docker-rmi-by-name() {
    id=$(docker images --filter=reference="$1:*" --format "{{ .ID }}")
    [ -n "$id" ] && docker rmi "$id"
}

docker-clean() {
    docker image prune --force
    docker container prune --force
    docker volume prune --force
    docker network prune --force
}

########## K8S
if command -v kubectl >/dev/null; then
    alias k='kubectl'
    alias kaf="kubectl apply -f"
    alias kcgc="kubectl config get-contexts"
    alias kgp="kubectl get pods"
    alias kgpa="kubectl get pods --all-namespaces"
    alias kgpl="kubectl get pods -l"
    alias kgpn="kubectl get pods -n"
    alias kgi="kubectl get ingress"
    alias kgns="kubectl get namespaces"
    alias kgcm="kubectl get configmaps"
    alias kgd="kubectl get deployment"
    alias kga="kubectl get all"
    alias kgaa="kubectl get all --all-namespaces"
    alias kl="kubectl logs"
    alias kgn="kubectl get nodes"

    if [ "$shell" = "zsh" ]; then
        source <(kubectl completion zsh)
    elif [ "$shell" = "bash" ]; then
        source <(kubectl completion bash)
    fi

    klist_pods() {
        kubectl get namespaces -o jsonpath='{.items[*].metadata.name}' | \
        tr ' ' '\n' | \
        while read -r ns; do
            echo "pods in $ns namespace:"
            kubectl get pods --namespace "$ns"
            printf '\n'
        done
    }

    klist_resources() {
        ns="${1:-kube-system}"
        kubectl api-resources --verbs=list --namespaced -o name \
            | xargs -n 1 kubectl get --show-kind --ignore-not-found --namespace "$ns"
    }
fi

if command -v kind >/dev/null; then
    if [ "$shell" = "zsh" ]; then
        source <(kind completion zsh)
    elif [ "$shell" = "bash" ]; then
        source <(kind completion bash)
    fi
fi
