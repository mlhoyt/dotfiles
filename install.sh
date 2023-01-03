#!/usr/bin/env bash
## This script is intended to be idempotent

set -E -o errexit -o nounset -o pipefail
trap "echo Error encountered -- exiting!" ERR

## install XCode Command Line Tools
# xcode-select --install

## install personal dotfiles
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

## install "bin"
ln -sf ${DOTFILES_ROOT}/bin ${HOME}/bin

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

## Update ~/.editrc
## man editrc
## This is the configuration for 'editline' library.
## macOS uses libedit readline instead of GNU readline.
## - Reference: https://stackoverflow.com/questions/70770189/how-to-substitute-libedit-readline-with-gnu-readline-on-mac-os
cat > ~/.editrc <<EOHI
bind -v
EOHI

# ## Update ~/.inputrc
# ## This is the configuration for GNU readline.
# ## Given macOS uses libedit readline this should not be necessary or have any effect.
# ## - Reference: https://unix.stackexchange.com/questions/424471/whats-the-difference-between-bashrc-and-inputrc
# cat > ~/.inputrc <<EOHI
# set editing-mode vi
# set keymap vi
# EOHI
