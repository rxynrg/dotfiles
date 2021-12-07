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
alias kgn="kubectl get nodes"

# shellcheck source=/dev/null
command -v kubectl &>/dev/null && source <(kubectl completion zsh)
