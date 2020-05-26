PROMPT="$ "
UNAME="$(uname -s)"
HOST="$(uname -n)"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Git
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM=verbose

export PS1='\u:\w$(__git_ps1 " (%s)")\$ '

# Aliases

## colourise ls
case $UNAME in
  Linux*)  alias ls='ls --color=auto';;
  Darwin*) alias ls="ls -G";;
esac

alias ll='ls -la' 

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias dev="cd ~/dev"
alias npm-check="npm pack && tar -xvzf *.tgz && rm -rf package *.tgz"
alias vim="nvim"

# Better Bash History -- https://sanctum.geek.nz/arabesque/better-bash-history/

## append to history file, rather than overwrite
shopt -s histappend

## record one command per line
shopt -s cmdhist

## increase history files sizes
HISTFILESIZE=1000000
HISTSIZE=1000000

## ignore both duplicate calls and commands starting with <Space>
HISTCONTROL=ignoreboth

## ignore some commands
HISTIGNORE='pm2:history'

## record a timestamp
HISTTIMEFORMAT='%F %T'

## record commands as they're issued (prevents losing history if a crash occurs)
PROMPT_COMMAND='history -a'
