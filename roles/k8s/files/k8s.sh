#!/usr/bin/env bash

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

    if [[ $SHELL == */zsh ]]
    then source <(kubectl completion zsh)
    else source <(kubectl completion bash)
    fi

    list_pods() {
      for ns in $(kubectl get namespaces | tail -n +2 | awk '{print $1}'); do
        echo pods in "$ns" namespace;
        kubectl get pods --namespace "$ns";
        printf '\n';
      done
    }

    list_resources() {
      kubectl api-resources --verbs=list --namespaced -o name \
        | xargs -n 1 kubectl get --show-kind --ignore-not-found --namespace kube-system
    }
fi
