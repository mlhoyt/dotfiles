#!/bin/sh

set -euf -o pipefail

# install XCode

# git clone https://github.com/mlhoyt/dotfiles.git

# install "dotfiles"
for i in .atom .bashrc .gitattributes .gitconfig .gnupg .vimrc bin
do
  ln -s ~/dotfiles/$i ~/$i
done

# install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install brew packages
for i in $(cat ~/dotfiles/brew.list)
do
  brew install ${i}
done

# install atom packages
apm install --packages-file ~/.atom/packages.list

# install JDK

# install Google Chrome

