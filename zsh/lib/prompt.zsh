setopt prompt_subst                                   # Evaluate prompt whenever displayed
autoload -Uz colors && colors                         # Colorize output

# git states
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[grey]%}(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[grey]%}) %{$fg[yellow]%}⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[grey]%})"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="%{$fg_bold[magenta]%}↓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="%{$fg_bold[magenta]%}↑%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="%{$fg_bold[magenta]%}↕%{$reset_color%}"

# ==================================================
# The prompt follows the format
# [user@host] current_dir (git_branch) git_state
# Example:
# [chirinosky@mybox] ~/.dotfiles (master) ⚡
# ==================================================
PROMPT='%{$fg_bold[grey]%}[%{$reset_color%}%{$fg_bold[green]%}%n@%m%{$reset_color%}%{$fg_bold[grey]%}]%{$reset_color%} %{$fg_bold[blue]%}%10c%{$reset_color%} $(git_prompt_info) $(git_remote_status)
%{$fg_bold[cyan]%}❯%{$reset_color%} '

# ==================================================
# Terminal title
# ==================================================
function title() {
    print -Pn "\e]2;%~\a"  # Display pwd
}
chpwd_functions=(${chpwd_functions[@]} "title")
