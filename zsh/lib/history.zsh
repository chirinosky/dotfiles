HISTSIZE=5000
SAVEHIST=5000
HISTFILE="$HOME/.zsh_history"
setopt APPEND_HISTORY                           # Multiple terminal sessions share same history
setopt INC_APPEND_HISTORY                       # Add entry to history as soon as it's entered
setopt HIST_IGNORE_DUPS                         # Do not write already-existing history events
setopt HIST_REDUCE_BLANKS                       # Remove extra blanks from commands added to history
