# Can install ohmyzsh and then add this file to bottom of ~/.zshrc (https://github.com/ohmyzsh/ohmyzsh).
# Can use theme https://github.com/win0err/aphrodite-terminal-theme by following repo instructions then setting ZSH_THEME="aphrodite/aphrodite" in zshrc
# So terminal colors work correctly
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Persistent history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Set default editor
export VISUAL=vim
export EDITOR="$VISUAL"

# So commands can be edited by external text editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line # May have to source ~/.zshrc in ~/.zprofile to get this to work from within tmux when it launches a login shell (when a login shell is launched this may not be sourced depending on the unix distro (some unix distros do something similar as recommended here to give consistency accross interactive sessions))

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
alias gcam="git commit -am"
alias gd="git diff"
alias cdschool="cd /Users/dalbyryan3/Documents/school"
alias cdprofessional="cd /Users/dalbyryan3/Documents/professional"

bindkey -e
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias tmux="tmux -2"

source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.2 # run chruby to see actual version

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

if [ "$IS_VSCODE" = true ] ; then
    tmux a -t vscode || tmux new -s vscode
fi
