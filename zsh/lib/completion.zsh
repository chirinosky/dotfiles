autoload -Uz compinit && compinit

unsetopt LIST_BEEP                                # Don't beep when ambiguous completion performed.

zstyle ':completion:*' menu select                # Enable menu to cycle completions
zstyle ':completion:*' completer _expand _complete _correct     # Enable command corrections
