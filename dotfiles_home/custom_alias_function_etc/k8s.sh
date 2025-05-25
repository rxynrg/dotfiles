if command -v kubectl > /dev/null; then
    alias k="kubectl"
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

    if [[ "$0" == *zsh ]]; then
        source <(kubectl completion zsh)
    elif [[ "$0" == *bash ]]; then
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
