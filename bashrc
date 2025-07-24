[[ $- != *i* ]] && return

shopt -s checkwinsize
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
export LESSHISTFILE=-

# enable programmable completion features if in not POSIX mode
! shopt -oq posix && {
  [ -f /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion ||
  [ -f /etc/bash_completion ] && . /etc/bash_completion
}

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.data"
export XDG_STATE_HOME="${HOME}/.data/state"

command -v mise >/dev/null && eval "$(mise activate bash)"

source "${XDG_CONFIG_HOME}/common_aliases_and_functions.sh"

command -v fzf >/dev/null && eval "$(fzf --bash)"
command -v zoxide >/dev/null && eval "$(zoxide init bash)"
command -v starship >/dev/null && eval "$(starship init bash)"
