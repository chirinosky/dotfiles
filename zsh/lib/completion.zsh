autoload -Uz compinit && compinit

setopt COMPLETE_IN_WORD                           # Completion takes place at cursor position
setopt ALWAYS_TO_END                              # Cursor moved to end of word after completion
setopt AUTO_CD                                    # CD if unused command matches directory name
unsetopt LIST_BEEP                                # Don't beep when ambiguous completion performed

zstyle ':completion:*' menu select                # Enable menu to cycle completions
zstyle ':completion:*' completer _expand _complete _correct     # Enable command corrections

# Colorize and compress info when killing processes
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
