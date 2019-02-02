# -*- sh -*-

alias vi=/usr/local/bin/vim
alias vim=/usr/local/bin/vim
set -o vi
tabs -2

alias ll="ls -al"

export EDITOR="vim"

# PATH
export PATH=${PATH}:${HOME}/bin

# bash-completion
# [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# dos2ux
alias dos2ux="tr -d '\r'"

# Perl
export PERL5LIB=${HOME}/perl5/lib

# Git
## bash-completion
source ${HOME}/.git-completion-bash
## PS1 util
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

# VirtualBox

# Vagrant

# Bosh

# Terraform (brew install tfenv)

# Ansible

# Docker

# Concourse

# Jenkins

# GPGTools

# Golang (brew install golang)
export GOPATH=${HOME}/go
export GOBIN=${GOPATH}/bin
export PATH=${PATH}:${GOBIN}

# Kubernetes
# source ${HOME}/.kube/setup_env.sh

# Scala (brew install scala)
# alias scala="scala-2.11"
# alias scalac="scalac-2.11"

# JavaScript
# alias jsc=/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Resources/jsc

# Misc
random-string() {
  # OPTIONS: [(LENGTH:-32) [(COUNT:-1)]]
  export LC_CTYPE=C
  cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n ${2:-1}
}

# Prompt
# see: http://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
# see: http://www.ltg.ed.ac.uk/~richard/utf-8.cgi?input=(UNICDE)&mode=hex c=$(printf "\x..\x..\x..")
# export PS1="\u@\h \W\$ "
C1="\e[7;39m"
C2="\e[7;33m"
C3="\e[7;31m"
CRST="\e[0m"
export PS1="\[\033]0;\007\]\[${C1}\]\u@\h\[${CRST}\] \[${C2}\]\W\[${CRST}\] \[${C3}\][\$(parse_git_branch)]\[${CRST}\]$ "
