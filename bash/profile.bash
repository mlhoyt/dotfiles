# -*- sh -*-

alias ll="ls -al"

set -o vi

# Brew
# open https://github.com/settings/tokens/new?scopes=gist,public_repo&description=Homebrew
# export HOMEBREW_GITHUB_API_TOKEN="..."

# Perl
export PERL5LIB="${HOME}/perl5/lib"

# dos2ux
alias dos2ux="tr -d '\r'"

# Go (brew install golang)
export GOPATH=${HOME}/go
export GOBIN=${GOPATH}/bin
export PATH=${PATH}:${GOBIN}

# Scala (brew install scala)
# alias scala="scala-2.11"
# alias scalac="scalac-2.11"

# Atom (brew cask install atom)

# JavaScript
# alias jsc=/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Resources/jsc

# Git
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
## enable git bash completion
# source ${HOME}/.git-completion-bash

# Prompt
# * see: http://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
# export PS1="\u@\h \W $(parse_git_branch)\$ "
C1="\e[7;39m"
C2="\e[7;33m"
C3="\e[7;31m"
CRST="\e[0m"
export PS1="\[\033]0;\007\]\[${C1}\]\u@\h\[${CRST}\] \[${C2}\]\W\[${CRST}\] \[${C3}\][\$(parse_git_branch)]\[${CRST}\]$ "
