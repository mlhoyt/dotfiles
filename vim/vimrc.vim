set nocompatible  " be iMproved, required
filetype off      " required

" vim +PluginInstall +qall
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
call vundle#end()
filetype plugin indent on

map <C-t> :NERDTreeToggle<CR>

set ruler
syntax on
set ff=unix
