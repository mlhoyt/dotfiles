#!/usr/bin/env bash
# This script is intended to be idempotent

set -E -o errexit -o nounset -o pipefail
trap "echo Error encountered -- exiting!" ERR

# install XCode

# git clone https://github.com/mlhoyt/dotfiles.git ${HOME}/dotfiles

DOTFILES_ROOT=$( cd "$(dirname "$0")" ; pwd -P )

# install "bashrc"
ln -sf ${DOTFILES_ROOT}/bash/profile.bash ${HOME}/.profile
ls -al ${HOME}/.profile

# install "vimrc"
printf "so ${DOTFILES_ROOT}/vim/vimrc.vim\n" > ${HOME}/.vimrc
ls -al ${HOME}/.vimrc

# install "atom"
ln -sf ${DOTFILES_ROOT}/atom ${HOME}/.atom
ls -al ${HOME}/.atom

# # install "dot" files
# for i in .gitattributes .gitconfig .gnupg bin
# do
#   ln -s ${DOTFILES_ROOT}/$i ${HOME}/$i
# done
# 
# # install git bash completion
# curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ${HOME}/.git-completion-bash
# echo "source ${HOME}/.git-completion-bash" >> ${HOME}/.bashrc
# 
# # install brew
# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# 
# # install brew packages
# for i in $(cat ${DOTFILES_ROOT}/brew.list)
# do
#   brew install ${i}
# done
# 
# # install npm packages
# for i in $(cat ${DOTFILES_ROOT}/npm.list)
# do
#   npm install -g ${i}
# done
# 
# # install atom packages
# apm install --packages-file ${HOME}/.atom/packages.list
# 
# # install JDK
# 
# # install Google Chrome
