zle -N self-insert url-quote-magic
# depend on the presence of zsh-history-substring-search plugin
zle -N history-substring-search-up
zle -N history-substring-search-down

_sudo_prefix() {
    [[ -z ${BUFFER} ]] && zle up-history
    [[ ${BUFFER} == sudo\ * ]] && BUFFER=${BUFFER#sudo } || BUFFER="sudo ${BUFFER}"
}
zle -N _sudo_prefix

bindkey '^[^[' _sudo_prefix # esc esc
bindkey '^[[1;5D' vi-backward-word # ctrl-left
bindkey '^[[1;5C' vi-forward-word # ctrl-right
bindkey '^[OA' history-substring-search-up # up
bindkey '^[OB' history-substring-search-down # down

zstyle ':completion:*:make:*:targets' call-command true # exec make to get targets
zstyle ':completion:*:make:*' tag-order targets # ignore make variables

zstyle ':completion:*' group-name ''
zstyle ':completion:*' gain-privileges true
# shellcheck disable=SC2296
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-cache true
zstyle ':completion:*' matcher-list '' \
    '+m:{a-z}={A-Z}' '+m:{A-Z}={a-z}' \
    'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
    'r:|?=** m:{a-z\-}={A-Z\_}'

_comp_options+=('globdots')
compinit
