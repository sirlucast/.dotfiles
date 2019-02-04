#!/bin/zsh
setopt prompt_subst

# Use syntax highlighting
if [ -f /Users/sirlucas/.dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
	source /Users/sirlucas/.dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Use history substring search
if [ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
	source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
fi

local dot_start='━╾'
local dot_ts='╼┥'
local dot_end='┝╾'
local sep='╌'
local datetime=" %D{%d-%m-%G} - %T"
local current='%B%F{cyan}%n%b%f at %B%F{magenta}%m%b%f in %B%F{yellow}%0~%b%f '
local insert='%F{yellow}❯❯ %f'
local nl=$'\n'

function __prompt()
{
    local dynamic_dots
    local branch
    local dirty
    local git_rev
    local ahead
    local behind

    local current_env=''
    if (( ${+VIRTUAL_ENV} )); then
        current_env='%B%F{white}($(basename $VIRTUAL_ENV))%b%f '
    fi

    datetime=" %D{%d-%m-%G} - %T"      
    let dots_count=${COLUMNS}-24 # dot_start(2) + dot_ts(2) + datetime(12) + time(8) tim + dot_end(2)        
    while [[ $dots_count -gt 0 ]]; do      
        dynamic_dots="${dynamic_dots}$sep"     
        let dots_count=${dots_count}-1     
    done       
    dynamic_dots="${dynamic_dots}"

    # Look for Git status
    if git status &>/dev/null; then
        branch="on %F{white}$(git branch --color=never | sed -ne 's/* //p')%f"
        git_rev="$(git rev-list --left-right @...@{u})"

        if git status -uno -s | grep -q . ; then
            dirty=" %F{white}●%f"
        fi

        behind="$(echo $git_rev | tr -d -c '>' | awk '{print length;}')"
        if [[ ! -z "${behind// }" ]]; then
            behind=" %F{red}⇣$behind%f"
        fi

        ahead="$(echo $git_rev | tr -d -c '<' | awk '{print length;}')"
        if [[ ! -z "${ahead// }" ]]; then
            ahead=" %F{green}⇡$ahead%f"
        fi

    fi
    
    #local insert='%b%F{yellow}❯❯%{$fg[red]%}%f%b'
    PROMPT="$dot_start$dynamic_dots$dot_ts$datetime$dot_end$nl$current$branch$dirty$behind$ahead$nl$current_env$insert"
   #SPROMPT="$current_env%F{yellow}❯%F{blue}❯%B%F{yellow}❯%b%f %f Correct %B%F{red}%R%b%f to %B%F{green}%r%b%f [nyae]? "
   SPROMPT="%F{yellow}◀ %f Correct %F{red}%R%f to %F{green}%r%f [nyae]? "
}
precmd () { __prompt }

RPROMPT='%B%F{red} %(?..E:%?)%b%f'
PROMPT2="%B%F{yellow}$PROMPT2%b%f"

# Use autosuggestion
if [ -f /Users/sirlucas/.dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
	source /Users/sirlucas/.dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
	ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
fi
