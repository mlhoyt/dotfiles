#!/usr/bin/env bash
## This script is intended to be idempotent

set -E -o errexit -o nounset -o pipefail
trap "echo Error encountered -- exiting!" ERR

## install XCode (xcode-select --install)

# git clone https://github.com/<GITHUB-USERNAME>/dotfiles.git ${HOME}/dotfiles

DOTFILES_ROOT=$( cd "$(dirname "$0")" ; pwd -P )

## install "zsh"
# chsh -s /bin/zsh
## install "oh-my-zsh" (configuration manager)
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

## install "zshrc"
ln -sf ${DOTFILES_ROOT}/zsh/zshrc ${HOME}/.zshrc
ls -al ${HOME}/.zshrc

## install "vimrc"
printf "so ${DOTFILES_ROOT}/vim/vimrc.vim\n" > ${HOME}/.vimrc
ls -al ${HOME}/.vimrc

## install "git"
ln -sf ${DOTFILES_ROOT}/git/config ${HOME}/.gitconfig
ln -sf ${DOTFILES_ROOT}/git/attributes ${HOME}/.gitattributes
touch ${HOME}/.gitcredentials
## install git bash completion
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ${HOME}/.git-completion-bash

## install brew
# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

## install brew packages
# for i in $(cat ${DOTFILES_ROOT}/brew.list)
# do
#   brew install ${i}
# done

## install npm packages
# for i in $(cat ${DOTFILES_ROOT}/npm.list)
# do
#   npm install -g ${i}
# done
