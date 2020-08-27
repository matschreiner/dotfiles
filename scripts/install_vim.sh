#!bin/bash/

sudo apt-get install vim

git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
vim +VimEnter +PluginInstall +qall


