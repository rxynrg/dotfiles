alias dis="docker images --format \"{{.ID}}\t{{.Size}}\t{{.Repository}}\" | sort -hk2"

docker_remove_image_by_name() {
  id=$(docker images --filter=reference="$1:*" --format "{{ .ID }}")
  [ ! -z "$id" ] && docker rmi "$id"
}

drm() {
  docker rmi $(docker images -f 'dangling=true' | awk '$1 == "<none>" { print $3 }' ORS=' ')
}
