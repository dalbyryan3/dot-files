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
alias cdschool="cd /Users/dalbyryan3/Documents/school"
alias cdresearch="cd /Users/dalbyryan3/Documents/school/research"
alias cdimgp="cd /Users/dalbyryan3/Documents/school/CS6640_ImageProcessing"
alias cdml="cd /Users/dalbyryan3/Documents/school/CS6350_MachineLearning"
alias cddl="cd /Users/dalbyryan3/Documents/school/CS6955_DeepLearning"
alias cdvr="cd /Users/dalbyryan3/Documents/school/CS6360_VirtualReality"
alias cdrobotsem="cd /Users/dalbyryan3/Documents/school/MEEN6892_RoboticsSeminar"
alias sshcade="ssh u0848407@lab1-15.eng.utah.edu"

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
conda activate
