# So terminal colors work correctly
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Set default editor 
export VISUAL=vim
export EDITOR="$VISUAL"

# So commands can be edited by external text editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Aliases
alias vi="mvim -v"
alias vim="mvim -v"
alias ll="ls -latr"
alias gs="git status"
alias gl="git log"
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m"
alias gd="git diff"
alias cdschool="cd /Users/dalbyryan3/Documents/school"
alias cdprofessional="cd /Users/dalbyryan3/Documents/professional"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/dalbyryan3/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/dalbyryan3/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/dalbyryan3/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/dalbyryan3/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

bindkey -e
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias tmux="tmux -2"

source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.2 # run chruby to see actual version
