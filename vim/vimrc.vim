set nocompatible  " Use Vim defaults instead of 100% vi compatibility Vundle:required
filetype off      " Vundle:required

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

" vim +PluginInstall +qall
" vim +PluginUpdate +qall
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" File Browser
Plugin 'scrooloose/nerdtree'
" Git
Plugin 'Xuyuanp/nerdtree-git-plugin'  " Git: status (for NERDTree)
Plugin 'airblade/vim-gitgutter'       " Git: diff
Plugin 'tpope/vim-commentary'
" Golang
Plugin 'fatih/vim-go'
" Terraform
Plugin 'hashivim/vim-terraform'
Plugin 'juliosueiras/vim-terraform-completion'
" Rust
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'
" Javascript
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'nsf/gocode', {'rtp': 'vim/'}
" Plugin 'Valloric/YouCompleteMe'
Plugin 'majutsushi/tagbar'
call vundle#end()

filetype plugin indent on
syntax on

" Map modes:
"   n: normal
"   v: visual
"   i: insert

let g:tagbar_ctags_bin='/usr/local/bin/ctags'

let mapleader = "."

" NERDTree settings / key bindings
" Fix NERDTree ^G before file/folder names - https://stackoverflow.com/questions/53657545/nerdtree-g-before-folder-and-file-names-osx-terminal-vim
let g:NERDTreeNodeDelimiter = "\u00a0"
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>w <C-w>

" vim-gitgutter settings / key bindings
nnoremap <leader>dh :GitGutterLineHighlightsToggle<CR>

let mapleader = ","

"
" Commenting (vim-commentary)
"

nnoremap <leader>/ :Commentary<CR>
vnoremap <leader>/ :Commentary<CR>

"
" Tagbar
"

nnoremap <leader>t :TagbarToggle<CR>

" Quick paste key bindings
" map <leader>p :r! pbpaste<CR>

"
" Golang
"

" map <C-j> :cnext<CR>
" map <C-k> :cprevious<CR>
" map <leader>j :cnext<CR>
" map <leader>k :cprevious<CR>
" nnoremap <leader>a :cclose<CR>
"
let g:go_fmt_autosave = 1
let g:go_fmt_command = "gofmt"
let g:go_fmt_options = '-s'
" let g:go_auto_type_info = 1
" autocmd FileType go nmap <leader>r <Plug>(go-run)
" autocmd FileType go nmap <leader>b <Plug>(go-build)
" let g:go_list_type = "quickfix"
let g:go_auto_sameids = 1
" let g:go_highlight_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_function_calls = 1
" " let g:go_highlight_operators = 1
" " let g:go_highlight_extra_types = 1
" let g:go_highlight_build_constraints = 1
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_debug_windows = {
  \ 'stack': 'leftabove 30vnew',
  \ 'vars':  'leftabove 70vnew',
  \ 'out':   'botright 10new',
\ }
" 'goroutines': 'botright 10new',
let g:go_debug_log_output = 'debugger'
let g:go_highlight_debug = 1
let g:go_highlight_diagnostic_errors = 0
let g:go_highlight_diagnostic_warnings = 0

augroup filetype_go
  autocmd!
  autocmd FileType go setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType go nnoremap <buffer> gi :GoInfo<CR>
  autocmd FileType go nnoremap <buffer> gd :GoDef<CR>
  autocmd FileType go nnoremap <buffer> gr :GoReferrers<CR>
  autocmd FileType go nnoremap <buffer> gif :GoImplements<CR>
  autocmd FileType go nnoremap <buffer> <s :GoDebugStart<CR>
  autocmd FileType go nnoremap <buffer> <b :GoDebugBreakpoint<CR>
  autocmd FileType go nnoremap <buffer> <c :GoDebugContinue<CR>
  autocmd FileType go nnoremap <buffer> <n :GoDebugNext<CR>
  autocmd FileType go nnoremap <buffer> <i :GoDebugStep<CR>
  autocmd FileType go nnoremap <buffer> <o :GoDebugStepOut<CR>
  autocmd FileType go nnoremap <buffer> <x :GoDebugStop<CR>
augroup END

"
" Terraform
"

let g:terraform_fmt_on_save=1
let g:terraform_fold_sections=1
let g:terraform_remap_spacebar=1

augroup filetype_terraform
  autocmd!
  autocmd FileType terraform setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup END

"
" Rust
"

let g:rustfmt_autosave = 1

augroup filetype_rust
  autocmd!
  autocmd FileType rust setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  " autocmd FileType rust nnoremap <buffer> gd <Plug>(rust-def)
  autocmd FileType rust nnoremap <buffer> gd :call racer#GoToDefinition()<CR>
  " autocmd FileType rust nnoremap <buffer> gi <Plug>(rust-doc)
  autocmd FileType rust nnoremap <buffer> gi :call racer#ShowDocumentation(0)<CR>
augroup END

" Python

augroup filetype_python
  autocmd!
  autocmd FileType python setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup END

" YouCompleteMe settings / key bindings
" disable auto_triggering ycm suggestions pane and instead use semantic completion only on Ctrl+n
" let ycm_trigger_key = '<C-n>'
" let g:ycm_auto_trigger = 0
" let g:ycm_key_invoke_completion = ycm_trigger_key

" Omni Completion (vim builtin??)
" trigger = <C-x><C-o>

let mapleader = "\\"

" Indentation: spaces-only (http://vim.wikia.com/wiki/Indenting_source_code)
" set autoindent
" expandtab - No tabs
" tabstop=<N> - The One True Tab
" shiftwidth=<N> - Number of spaces to shift for autoindent or >,<
" softtabstop=<N> - Spaces 'feel' like tabs
set backspace=indent,eol,start

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
" set ignorecase
" Allow <tab> to jump to matching enclosure (paren, bracket, sqbracket, etc)
nnoremap <tab> %

" Enables automatic file write on specific commands
set autowrite

autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Whitespace character visibility
" ref: https://www.barcodefaq.com/knowledge-base/mac-extended-ascii-character-chart/
" 200 = » = <opt>+<shft>+\
" 224 = ‡ = <opt>+<shft>+7
set listchars=tab:»\ ,extends:›,precedes:‹,space:·,trail:~,eol:=
" set listchars=tab:»\ ,space:\ ,trail:~,eol:\ 
set nolist
