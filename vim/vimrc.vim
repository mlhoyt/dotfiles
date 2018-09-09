set nocompatible  " Use Vim defaults instead of 100% vi compatibility Vundle:required
filetype off      " Vundle:required

" vim +PluginInstall +qall
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'fatih/vim-go'
Plugin 'hashivim/vim-terraform'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-commentary'
call vundle#end()
filetype plugin indent on

" NERDTree key bindings
let mapleader = "."
map <leader>t :NERDTreeToggle<CR>
map <leader>w <C-w>

" vim-go key bindings
" map <C-j> :cnext<CR>
" map <C-k> :cprevious<CR>
let mapleader = ","
noremap <leader>/ :Commentary<CR>
map <leader>j :cnext<CR>
map <leader>k :cprevious<CR>
" autocmd FileType go nmap <leader>i <Plug>(go-info)
" autocmd FileType go nmap <leader>r <Plug>(go-run)
" autocmd FileType go nmap <leader>b <Plug>(go-build)
" let g:go_list_type = "quickfix"
let g:go_auto_sameids = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1

" vim-terraform
let g:terraform_fold_sections=1
let g:terraform_remap_spacebar=1
" let g:terraform_fmt_on_save=1

let mapleader = "\\"

" Indentation: spaces-only (http://vim.wikia.com/wiki/Indenting_source_code)
" set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Code Folding
set foldmethod=syntax
set foldnestmax=1
set foldlevelstart=10

" General Vim settings
syntax on
set number
set ruler
" set ff=unix
" set relativenumber
set cursorline
hi Cursor ctermfg=White ctermbg=Yellow cterm=bold guifg=white guibg=yellow gui=bold
set dir=/tmp/
set hlsearch
set incsearch
map <tab> %

" Enables automatic file write on specific commands
set autowrite

autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
