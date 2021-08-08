# History settings
export HISTFILE=~/.zsh_history
export HISTSIZE=5000
export SAVEHIST=5000
export HISTCONTROL=ignoredups
setopt append_history # Do not overwrite, append.
setopt inc_append_history # Write after each command.
setopt hist_expire_dups_first # Expire duplicate entries first when trimming history.
setopt hist_fcntl_lock # Use OS file locking.
setopt hist_ignore_all_dups # Delete old recorded entry if new entry is a duplicate.
setopt hist_lex_words # Better word splitting, but more CPU heavy.
setopt hist_reduce_blanks # Remove superfluous blanks before recording entry.
setopt hist_save_no_dups # Do not write duplicate entries in the history file.
setopt share_history # Share history between multiple shells.
setopt hist_ignore_space # Do not record an entry starting with a space.
