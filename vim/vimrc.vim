set nocompatible  " Use Vim defaults instead of 100% vi compatibility Vundle:required
filetype off      " Vundle:required

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

" vim +PluginInstall +qall
" vim +PluginUpdate +qall
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" File Browser (.-t)
Plugin 'scrooloose/nerdtree'
" Git
Plugin 'Xuyuanp/nerdtree-git-plugin'  " Git: status (for NERDTree)
Plugin 'airblade/vim-gitgutter'       " Git: diff
" Commenting (,-/)
Plugin 'tpope/vim-commentary'
" Tagbar (,-t)
Plugin 'majutsushi/tagbar'
" ALE
Plugin 'dense-analysis/ale'
" Golang
Plugin 'fatih/vim-go'
" Terraform
Plugin 'hashivim/vim-terraform'
Plugin 'juliosueiras/vim-terraform-completion'
" Rust
Plugin 'rust-lang/rust.vim'
" Plugin 'racer-rust/vim-racer'
" Lua
" Python
" Plugin 'psf/black'
" JavaScript
Plugin 'pangloss/vim-javascript'
" Another option?: "yuezk/vim-js"
" TypeScript
Plugin 'leafgarland/typescript-vim'
" JSX/TSX
" Deprecated: Plugin 'mxw/vim-jsx'
Plugin 'MaxMEllon/vim-jsx-pretty'
" Plugin 'peitalin/vim-jsx-typescript'
" GraphQL
Plugin 'jparise/vim-graphql'
" CtrlP
Plugin 'ctrlpvim/ctrlp.vim'
call vundle#end()

filetype plugin indent on
syntax on

"
" Defaults
"

" set autoindent
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set backspace=indent,eol,start

" Map modes:
"   n: normal
"   v: visual
"   i: insert

let mapleader = "."

"
" File Browser (NERDTree)
" NOTE: Fix NERDTree ^G before file/folder names - https://stackoverflow.com/questions/53657545/nerdtree-g-before-folder-and-file-names-osx-terminal-vim
"

let g:NERDTreeNodeDelimiter = "\u00a0"
let g:NERDTreeShowHidden = 1

nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>w <C-w>

"
" Git
"

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

let g:tagbar_ctags_bin='/opt/homebrew/Cellar/ctags/5.8_2/bin/ctags'

nnoremap <leader>t :TagbarToggle<CR>

" Quick paste key bindings
" map <leader>p :r! pbpaste<CR>

"
" ALE
" - refs
"   - https://github.com/dense-analysis/ale/blob/master/doc/ale.txt
"   - https://www.vimfromscratch.com/articles/vim-and-language-server-protocol/
" - debugging notes
"   - use `:ALEInfo`
"   - use `:echo g:ale_buffer_info`
"   - https://github.com/dense-analysis/ale/issues/2137
"     - use vimrc `let g:ale_command_wrapper = '~/.local/bin/ale-command-wrapper.sh'`
"         - This allows you to debug interactions with language servers

let g:ale_linters = {}
let g:ale_fixers = {}
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
" Hover information is displayed in a hovering window.
" Requires Vim supports the |balloon_show()| function.
" Does NOT seem to work implying the install Vim does not support the above function.
" let g:ale_set_balloons=1
" let g:ale_hover_to_preview=1
let g:ale_hover_to_floating_preview=1
let g:ale_completion_enabled=1
set omnifunc=ale#completion#OmniFunc
let g:ale_virtualtext_cursor='current'

"
" Golang
" - updates:
"   - brew upgrade go
"

" map <C-j> :cnext<CR>
" map <C-k> :cprevious<CR>
" map <leader>j :cnext<CR>
" map <leader>k :cprevious<CR>
" nnoremap <leader>a :cclose<CR>

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

let g:ale_linters['terraform'] = ['terraform', 'terraform_ls']
let g:ale_fixers['terraform'] = ['terraform']

augroup filetype_terraform
  autocmd!
  autocmd FileType terraform setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType terraform nnoremap <buffer> gd :ALEGoToDefinition<CR>
  autocmd FileType terraform nnoremap <buffer> gr :ALEFindReferences<CR>
  autocmd FileType terraform nnoremap <buffer> gi :ALEHover<CR>
augroup END

"
" Rust
" - updates:
"   - rustup
"     - rustup check
"     - rustup update
"   - rust-analyzer
"     - mkdir -p ~/.local/bin
"     - curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-aarch64-apple-darwin.gz | gunzip -c - > ~/.local/bin/rust-analyzer
"     - chmod +x ~/.local/bin/rust-analyzer
"     - ~/.local/bin/rust-analyzer --version

let g:ale_linters['rust'] = ['analyzer', 'cargo']
" let g:ale_rust_analyzer_config = {
"   \ 'rust-analyzer.diagnostics.enable': v:true,
"   \ 'rust-analyzer.trace.server': 'verbose'
"   \ }
let g:ale_fixers['rust'] = ['rustfmt']
let g:rustfmt_autosave = 1

augroup filetype_rust
  autocmd!
  autocmd FileType rust setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
  " " autocmd FileType rust nnoremap <buffer> gd <Plug>(rust-def)
  " autocmd FileType rust nnoremap <buffer> gd :call racer#GoToDefinition()<CR>
  " " autocmd FileType rust nnoremap <buffer> gi <Plug>(rust-doc)
  " autocmd FileType rust nnoremap <buffer> gi :call racer#ShowDocumentation(0)<CR>
  autocmd FileType rust nnoremap <buffer> gd :ALEGoToDefinition<CR>
  autocmd FileType rust nnoremap <buffer> gr :ALEFindReferences<CR>
  autocmd FileType rust nnoremap <buffer> gi :ALEHover<CR>
augroup END

"
" Lua
" - updates:
"   - brew upgrade lua
"

"
" Python
"

" https://black.readthedocs.io/en/stable/editor_integration.html#vim
" let g:black_linelength = 256

augroup filetype_python
  autocmd!
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
augroup END

" autocmd BufWritePost *.py silent! execute ':Black'

"
" JavaScript
" - requires: npm install -g typescript
"   - This installs 'tsserver' which acts as the ALE language server to provide
"     code navigation
"

let g:ale_linters['javascript'] = ['eslint']
let g:ale_fixers['javascript'] = ['eslint']

augroup filetype_javascript_jsx
  autocmd!
  autocmd FileType javascript.jsx setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
  autocmd FileType javascript.jsx nnoremap <buffer> gd :ALEGoToDefinition<CR>
  autocmd FileType javascript.jsx nnoremap <buffer> gr :ALEFindReferences<CR>
  autocmd FileType javascript.jsx nnoremap <buffer> gi :ALEHover<CR>
augroup END

"
" TypeScript
" - requires: npm install [-g] typescript
"   - This installs 'tsserver' which acts as the ALE language server to provide
"     code navigation
"

let g:ale_linters['typescript'] = ['eslint', 'tsserver']
let g:ale_fixers['typescript'] = ['eslint']

augroup filetype_typescript
  autocmd!
  autocmd FileType typescript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType typescript nnoremap <buffer> gd :ALEGoToDefinition<CR>
  autocmd FileType typescript nnoremap <buffer> gr :ALEFindReferences<CR>
  autocmd FileType typescript nnoremap <buffer> gi :ALEHover<CR>
augroup END

let g:ale_linters['typescriptreact'] = ['eslint', 'tsserver']
let g:ale_fixers['typescriptreact'] = ['eslint']

augroup filetype_typescriptreact
  autocmd!
  autocmd FileType typescriptreact setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType typescriptreact nnoremap <buffer> gd :ALEGoToDefinition<CR>
  autocmd FileType typescriptreact nnoremap <buffer> gr :ALEFindReferences<CR>
  autocmd FileType typescriptreact nnoremap <buffer> gi :ALEHover<CR>
augroup END

"
" GraphQL
"

let g:ale_linters['graphql'] = ['eslint']
let g:ale_fixers['graphql'] = ['prettier']

" Omni Completion (vim builtin??)
" trigger = <C-x><C-o>

let mapleader = "\\"

"
" SQL
"

let g:ale_linters['sql'] = ['pgformatter']
let g:ale_fixers['sql'] = ['prettier']

"
" Indentation
" NOTE: Syntax-specific settings should be in appropriate augroups for the FileType
" NOTE: spaces-only (http://vim.wikia.com/wiki/Indenting_source_code)
"

"
" Code Folding
"

set foldmethod=syntax
set foldnestmax=1
set foldlevelstart=10

"
" General Vim settings
"

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
nnoremap <tab> % " Allow <tab> to jump to matching enclosure
set autowrite " Enables automatic file write on specific commands
" Reference: https://thoughtbot.com/blog/wrap-existing-text-at-80-characters-in-vim
" Use 'v' to highlight and ':gq' to format selected lines
set textwidth=100

autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"
" Whitespace character visibility
" REF: https://www.barcodefaq.com/knowledge-base/mac-extended-ascii-character-chart/
" 200 = » = <opt>+<shft>+\
" 224 = ‡ = <opt>+<shft>+7
"

set listchars=tab:»\ ,extends:›,precedes:‹,space:·,trail:~,eol:=
set nolist
