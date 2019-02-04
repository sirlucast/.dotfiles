export LANG=en_US.UTF-8		
export LC_ALL=en_US.UTF-8

# Historial
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE
export HISTFILE="$HOME/.zsh_history"
WORDCHARS=${WORDCHARS//\/[&.;]}


POWERLINE_DETECT_SSH="true"
POWERLINE_GIT_CLEAN="✔"
POWERLINE_GIT_DIRTY="✘"
POWERLINE_GIT_ADDED="%F{green}✚%F{black}"
POWERLINE_GIT_MODIFIED="%F{blue}✹%F{black}"
POWERLINE_GIT_DELETED="%F{red}✖%F{black}"
POWERLINE_GIT_UNTRACKED="%F{yellow}✭%F{black}"
POWERLINE_GIT_RENAMED="➜"
POWERLINE_GIT_UNMERGED="═"

# Opciones
setopt BANG_HIST  # Treat the '!' character specially during expansion.
# setopt EXTENDED_HISTORY  # Write the history file in the ":start:elapsed;command" format.
# setopt INC_APPEND_HISTORY  # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY  # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST  # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS  # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS  # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS  # Do not display a line previously found.
setopt HIST_IGNORE_SPACE  # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS  # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS  # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY  # Don't execute immediately upon history expansion.
setopt HIST_BEEP  # Beep when accessing nonexistent history.
setopt AUTO_CD # Allow directory change without using cd command
setopt CORRECT  # Corrects commmands misspellings
#setopt extendedglob  # Extended globbing. Allows using regular expressions with *
#setopt nocaseglob  # Case insensitive globbing
#setopt rcexpandparam  # Array expension with parameters
#setopt numericglobsort  # Sort filenames numerically when it makes sense
#setopt appendhistory  # Immediately append history instead of overwriting


# Setear el titulo de una pestaña
DISABLE_AUTO_TITLE="true"
tt () {
    echo -ne "\e]1;$@\a"
}

# Cargar autocompletado
fpath=(/usr/local/share/zsh-completions $fpath)
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
# zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Acelerar autocompletado
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache



# pyenv init
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

if hash brew 2>/dev/null; then
    export PATH=/usr/local/bin:$PATH
fi

if [ -d ~/.local/bin/ ]; then
    export PATH=~/.local/bin:$PATH
fi

# pyenv
if [ -d ~/.pyenv/ ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then
        eval "$(pyenv init -)"
    fi
fi

# poetry
if [ -d ~/.pyenv/ ]; then
    fpath+=~/.zfunc
    export PATH="$HOME/.poetry/bin:$PATH"
fi

# Gitignore.io
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}


# Prompt
if [ -f ~/.dotfiles/zsh/prompt.zsh ]; then
    source ~/.dotfiles/zsh/prompt.zsh
fi

source /Users/sirlucas/.dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /Users/sirlucas/.dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
