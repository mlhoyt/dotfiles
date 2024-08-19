set nocompatible  " Use Vim defaults instead of 100% vi compatibility

set shell=/bin/bash

" disable audible bell
set visualbell
set t_vb=

" Statusline
" https://hackernoon.com/the-last-statusline-for-vim-a613048959b2
set laststatus=2
set statusline=
set statusline+=%f         " path
set statusline+=%=         " switch to right side
set statusline+=%1*%y%*\   " file type
set statusline+=[%{strlen(&fenc)?&fenc:'none'}]\ " encoding type
set statusline+=(%l,%c)\   " line and column
set statusline+=%L         " total lines

syntax off
colorscheme industry

" Reference: https://vi.stackexchange.com/questions/16795/how-could-i-create-a-terminal-at-the-bottom
set splitbelow

" Map modes:
"   n: normal
"   v: visual
"   i: insert

let mapleader = "."

" Pane navigation
nnoremap <leader>w <C-w>

" General Settings
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set backspace=indent,eol,start
set number
set ruler
" set ff=unix
set cursorline
hi Cursor ctermfg=White ctermbg=Yellow cterm=bold guifg=white guibg=yellow gui=bold
set dir=/tmp/
set hlsearch
set incsearch
nnoremap <tab> % " Allow <tab> to jump to matching enclosure
set autowrite " Enables automatic file write on specific commands

" Reference: https://thoughtbot.com/blog/wrap-existing-text-at-80-characters-in-vim
" Use 'v' to highlight and ':gq' to format selected lines
set textwidth=100

" Whitespace character visibility
" REF: https://www.barcodefaq.com/knowledge-base/mac-extended-ascii-character-chart/
set listchars=tab:»\ ,extends:›,precedes:‹,space:·,trail:~,eol:=
set nolist
