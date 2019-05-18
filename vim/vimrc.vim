set nocompatible  " Use Vim defaults instead of 100% vi compatibility Vundle:required
filetype off      " Vundle:required

" disable audible bell
set visualbell
set t_vb=

" https://hackernoon.com/the-last-statusline-for-vim-a613048959b2
set laststatus=2
set statusline=
set statusline+=%f        " path
set statusline+=%=        " switch to right side
set statusline+=%1*%y%*\  " file type
set statusline+=(%l,%c)\  " line and column
set statusline+=%L        " total lines

" vim +PluginInstall +qall
" vim +PluginUpdate +qall
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'          " File browser
Plugin 'Xuyuanp/nerdtree-git-plugin'  " Git: status (for NERDTree)
Plugin 'airblade/vim-gitgutter'       " Git: diff
Plugin 'tpope/vim-commentary'
Plugin 'fatih/vim-go'                 " Golang
Plugin 'hashivim/vim-terraform'
Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'nsf/gocode', {'rtp': 'vim/'}
" Plugin 'Valloric/YouCompleteMe'
call vundle#end()
filetype plugin indent on
syntax on

" NERDTree key bindings
let mapleader = "."
" Fix NERDTree ^G before file/folder names - https://stackoverflow.com/questions/53657545/nerdtree-g-before-folder-and-file-names-osx-terminal-vim
let g:NERDTreeNodeDelimiter = "\u00a0"
map <leader>t :NERDTreeToggle<CR>
map <leader>w <C-w>

map <leader>dh :GitGutterLineHighlightsToggle<CR>

" vim-go key bindings
" map <C-j> :cnext<CR>
" map <C-k> :cprevious<CR>
let mapleader = ","
noremap <leader>/ :Commentary<CR>
map <leader>j :cnext<CR>
map <leader>k :cprevious<CR>
nnoremap <leader>a :cclose<CR>
nnoremap <leader>i :GoInfo<CR>
let g:go_auto_type_info = 1
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
let g:go_def_mode='gopls'

" vim-terraform
let g:terraform_fold_sections=1
let g:terraform_remap_spacebar=1
" let g:terraform_fmt_on_save=1

" YCM - YouCompleteMe
" disable auto_triggering ycm suggestions pane and instead use semantic completion only on Ctrl+n
" let ycm_trigger_key = '<C-n>'
" let g:ycm_auto_trigger = 0
" let g:ycm_key_invoke_completion = ycm_trigger_key

let mapleader = "\\"

" Indentation: spaces-only (http://vim.wikia.com/wiki/Indenting_source_code)
" set autoindent
set expandtab      " No tabs
set tabstop=2      " The One True Tab
set shiftwidth=2   " Number of spaces to shift for autoindent or >,<
set softtabstop=2  " Spaces 'feel' like tabs

" Code Folding
set foldmethod=syntax
set foldnestmax=1
set foldlevelstart=10

" General Vim settings
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

" Whitespace character visibility
set listchars=tab:»\ ,extends:›,precedes:‹,space:·,trail:~,eol:=
set nolist
