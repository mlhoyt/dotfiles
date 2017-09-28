#!/usr/bin/env sh

set -euf -o pipefail

# install XCode

# git clone https://github.com/mlhoyt/dotfiles.git

DOTFILES_ROOT=$( cd "$(dirname "$0")" ; pwd -P )

# install "dot" files
for i in .atom .bashrc .gitattributes .gitconfig .gnupg .vimrc bin
do
  ln -s ${DOTFILES_ROOT}/$i ${HOME}/$i
done

# install git bash completion
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ${HOME}/.git-completion-bash
echo "source ${HOME}/.git-completion-bash" >> ${HOME}/.bashrc

# install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install brew packages
for i in $(cat ${DOTFILES_ROOT}/brew.list)
do
  brew install ${i}
done

# install npm packages
for i in $(cat ${DOTFILES_ROOT}/npm.list)
do
  npm install -g ${i}
done

# install atom packages
apm install --packages-file ${HOME}/.atom/packages.list

# install JDK

# install Google Chrome

