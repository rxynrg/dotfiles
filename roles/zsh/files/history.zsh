export HISTSIZE=500000
export SAVEHIST=$HISTSIZE
export HISTFILE="$HOME/.history"

setopt append_history           # do not overwrite, append
setopt extended_history         # record timestamp of command in HISTFILE
setopt hist_expire_dups_first   # expire duplicate entries first when trimming history
setopt hist_fcntl_lock          # use OS file locking
setopt hist_ignore_all_dups     # delete old recorded entry if new entry is a duplicate
setopt hist_ignore_space        # do not record an entry starting with a space
setopt hist_lex_words           # better word splitting, but more CPU heavy
setopt hist_reduce_blanks       # remove superfluous blanks before recording entry
setopt hist_save_no_dups        # do not write duplicate entries in the history file
setopt inc_append_history       # write after each command
setopt share_history            # share history between multiple shells
