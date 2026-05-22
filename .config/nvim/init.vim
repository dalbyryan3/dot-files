set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
let g:loaded_flagship = 1
source ~/.vimrc
lua require('config')
