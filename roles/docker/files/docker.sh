#!/usr/bin/env bash

alias dis="docker images --format \"{{.ID}}\t{{.Size}}\t{{.Repository}}\" | sort -hk2"

docker-rmi-by-name() {
  id=$(docker images --filter=reference="$1:*" --format "{{ .ID }}")
  [ -n "$id" ] && docker rmi "$id"
}

alias docker-rmi-force='docker rmi -f $(docker images -a -q)'
alias docker-rmc-force='docker ps -q | xargs docker rm -f'
alias docker-rmc="docker ps -a --filter=status=exited --format='{{ .ID }}' | xargs docker rm"

docker-clean() {
  docker image prune --force
  docker container prune --force
  docker volume prune --force
  docker network prune --force
}
