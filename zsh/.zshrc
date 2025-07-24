[[ $- != *i* ]] && return

source "${ZDOTDIR}/setopt.zsh"
source "${ZDOTDIR}/load.zsh"
source "${ZDOTDIR}/zle.zsh"
source "${XDG_CONFIG_HOME}/common_aliases_and_functions.sh"

source "${ZDOTDIR}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "${ZDOTDIR}/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
source "${ZDOTDIR}/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"

cache_eval_output mise 'mise activate zsh'

source <(fzf --zsh)

_zoxide_lazy_init() {
  unalias z
  cache_eval_output zoxide 'zoxide init zsh'
  z "$@"
}
alias z='_zoxide_lazy_init'

eval "$(starship init zsh)"
