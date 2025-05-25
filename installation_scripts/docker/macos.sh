#!/usr/bin/env bash

brew install docker docker-compose docker-buildx

mkdir -p "$HOME/.docker/cli-plugins"
ln -sf "$(brew --prefix)/opt/docker-compose/bin/docker-compose" "$HOME/.docker/cli-plugins/docker-compose"
ln -sf "$(brew --prefix)/opt/docker-buildx/bin/docker-buildx" "$HOME/.docker/cli-plugins/docker-buildx"
