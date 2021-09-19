alias dis="docker images --format \"{{.ID}}\t{{.Size}}\t{{.Repository}}\" | sort -hk2"

drm() {
  docker rmi "$(docker images -f 'dangling=true' | awk '{if ($1 == "<none>") {print $3 } ')"
}
