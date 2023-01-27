# History settings
export HISTFILE="$XDG_DATA_HOME/.zsh_history"
export HISTSIZE=5000
export SAVEHIST=5000
export HISTCONTROL=ignoredups

# Do not overwrite, append.
setopt append_history

# Write after each command.
setopt inc_append_history

# Expire duplicate entries first when trimming history.
setopt hist_expire_dups_first

# Use OS file locking.
setopt hist_fcntl_lock

# Delete old recorded entry if new entry is a duplicate.
setopt hist_ignore_all_dups

# Better word splitting, but more CPU heavy.
setopt hist_lex_words

# Remove superfluous blanks before recording entry.
setopt hist_reduce_blanks

# Do not write duplicate entries in the history file.
setopt hist_save_no_dups

# Share history between multiple shells.
setopt share_history

# Do not record an entry starting with a space.
setopt hist_ignore_space
