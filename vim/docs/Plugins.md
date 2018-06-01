# Vundle

From https://github.com/VundleVim/Vundle.vim:
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

# NerdTree

Add the following to `${HOME}/.vimrc`:

```
Plugin 'scrooloose/nerdtree'
map <C-t> :NERDTreeToggle<CR>
```

Run the following to use Vundle to install the desired package:

```
vim +PluginInstall +qall
```
