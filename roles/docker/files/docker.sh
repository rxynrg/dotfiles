alias dis="docker images --format \"{{.ID}}\t{{.Size}}\t{{.Repository}}\" | sort -hk2"

docker_remove_image_by_name() {
  id=$(docker images --filter=reference="$1:*" --format "{{ .ID }}")
  [ ! -z "$id" ] && docker rmi "$id"
}

alias drm-imgs='docker rmi -f $(docker images -a -q)'
alias drm-containers-force='docker ps -q | xargs docker rm -f'

drm() {
  docker rmi $(docker images -f 'dangling=true' | awk '$1 == "<none>" { print $3 }' ORS=' ')
}
