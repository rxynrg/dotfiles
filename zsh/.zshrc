[[ $- != *i* ]] && return

source "${ZDOTDIR}/setopt.zsh"
source "${ZDOTDIR}/load.zsh"
source "${ZDOTDIR}/zle.zsh"
source "${XDG_CONFIG_HOME}/common_aliases_and_functions.sh"

source "${ZDOTDIR}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
# https://github.com/zdharma-continuum/fast-syntax-highlighting.git
source "${ZDOTDIR}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "${ZDOTDIR}/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"

eval "$(mise activate zsh)"
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

cd ~
