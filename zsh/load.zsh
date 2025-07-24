autoload -Uz colors && colors
autoload -Uz select-word-style && select-word-style bash
autoload -Uz url-quote-magic
autoload -Uz compinit

function cache_eval_output() {
  local key=$1
  local cmd=$2
  local cache_file="${XDG_CACHE_HOME}/zsh-init/${key}.zsh"
  mkdir -p "$(dirname "$cache_file")"
  if [[ ! -f "$cache_file" || "$(command -v $key)" -nt "$cache_file" ]]; then
    echo "Rebuilding cache: $cache_file"
    eval "$cmd" > "$cache_file"
  fi
  source "$cache_file"
}
