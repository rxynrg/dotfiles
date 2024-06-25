#!/usr/bin/env bash

function mkcd () {
  mkdir -p "$*"
  cd "$*" || return
}

if command -v eza > /dev/null; then
  alias ls="eza"
  alias ll="eza --long"
  alias la="eza --long --all"
  alias lt="eza --icons --tree"
fi

alias ghtoken="cat ~/.env | grep GH_TOKEN | cut -d '=' -f 2 | pbcopy"
alias whereami="curl https://ifconfig.co/json"
alias afk="open /System/Library/CoreServices/ScreenSaverEngine.app"

function ytdlp_cmd {
  docker run --rm -it -v "$(pwd):/downloads:rw" jauderho/yt-dlp:2023.03.04 "$@"
}

# 1 - input file name (input.mp4)
# 2 - from time (00:05:10)
# 3 - to time (01:15:30)
# 4 - ouput file name (output.mp4)
function ffmpeg_trim {
  docker run --rm -it -v "$(pwd):/config" linuxserver/ffmpeg:version-6.0-cli \
    -i "/config/$1" -ss $2 -to $3 -c:v copy -c:a copy "/config/$4"
}

# Usage
# *args - file names to concat
function ffmpeg_concat {
  fname="$(date +%s)".txt
  while [ "$1" != "" ]; do
    echo "file '${1}'" >> ${fname} && shift
  done
  docker run --rm -it -v "$(pwd):/config" linuxserver/ffmpeg:version-6.0-cli \
    -f concat -safe 0 -i "/config/${fname}" -c copy "/config/$fname.mp4"
  rm ${fname}
}
