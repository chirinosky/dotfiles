function git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function git_remote_status() {
    remote=${$(command git rev-parse --verify ${hook_com[branch]}@{upstream} --symbolic-full-name 2>/dev/null)/refs\/remotes\/}
    if [[ -n ${remote} ]]; then
        ahead=$(command git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null |wc -l)
        behind=$(command git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null |wc -l)

        if [ $ahead -eq 0 ] && [ $behind -gt 0 ]; then
            echo "$ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE"
        elif [ $ahead -gt 0 ] && [ $behind -eq 0 ]; then
            echo "$ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE"
        elif [ $ahead -gt 0 ] && [ $behind -gt 0 ]; then
            echo "$ZSH_THEME_GIT_PROMPT_DIVEREGED_REMOTE"
        fi
    fi
}

function parse_git_dirty () {
    if [[ -n $(git status -s 2> /dev/null) ]]; then
        echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
    else
        echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
    fi
}
