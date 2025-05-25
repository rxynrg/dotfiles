[[ $- != *i* ]] && return

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
# check the window size after each command and,
# if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
# enable programmable comp features if in not POSIX mode
! shopt -oq posix && {
  [ -f /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion ||
  [ -f /etc/bash_completion ] && . /etc/bash_completion
}

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.data"
export XDG_STATE_HOME="${HOME}/.data/state"
# export PATH="$HOME/.local/bin:$PATH"
source "${XDG_CONFIG_HOME}/common_aliases_and_functions.sh"
command -v fzf > /dev/null && eval "$(fzf --bash)"
command -v starship > /dev/null && eval "$(starship init bash)"
command -v zoxide > /dev/null && eval "$(zoxide init bash)"
