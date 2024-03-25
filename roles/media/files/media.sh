#!/usr/bin/env bash

YTDLP="jauderho/yt-dlp:2023.03.04"
FFMPEG="linuxserver/ffmpeg:version-6.0-cli"

alias yt-dlp='docker run \
                  --rm -i \
                  -e PGID=$(id -g) \
                  -e PUID=$(id -u) \
                  -v "$(pwd)":/workdir:rw \
                  "$YTDLP"'

# Usage
# *args - URLs to download files from
function ytdlp {
  docker run --rm -it -v "$(pwd):/downloads:rw" "$YTDLP" "$@"
}

# 1 - input file name (input.mp4)
# 2 - from time (00:05:10)
# 3 - to time (01:15:30)
# 4 - ouput file name (output.mp4)
function ffmpeg_trim {
  docker run --rm -it -v "$(pwd):/config" "$FFMPEG" \
    -i "/config/$1" -ss "$2" -to "$3" -c:v copy -c:a copy "/config/$4"
}

# Usage
# *args - file names to concat
function ffmpeg_concat {
  fname="$(date +%s)".txt
  while [ "$1" != "" ]; do
    echo "file '${1}'" >> "${fname}" && shift
  done
  docker run --rm -it -v "$(pwd):/config" "$FFMPEG" \
    -f concat -safe 0 -i "/config/${fname}" -c copy "/config/$fname.mp4"
  rm "${fname}"
}
