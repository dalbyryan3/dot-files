set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins to install
" supertab for code-completion
Plugin 'https://github.com/ervandew/supertab.git'
" commentary to easily comment
Plugin 'https://tpope.io/vim/commentary.git'
" sleuth for tabs/spaces detection
Plugin 'https://tpope.io/vim/sleuth.git'
" one Dark theme
Plugin 'https://github.com/joshdick/onedark.vim.git'
" fugitive for git integration
Plugin 'https://tpope.io/vim/fugitive.git'
" fzf for fuzzy search
Plugin 'https://github.com/junegunn/fzf.git'
Plugin 'https://github.com/junegunn/fzf.vim.git'

call vundle#end()
" Turn on file type detection, plugin, and indent
filetype plugin indent on


" General Vim setup:
" Syntax highlighting
syntax on
" Turn on relative line numbering
set relativenumber
" Color scheme
colorscheme onedark
" Set line numbers
set number
" Set tabs as spaces initially, sleuth will adjust based on file
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
" Allow for switching between edited buffers
set hidden
" Turn off flashing/visual bell, may need newer Vim version (7.4+) so may need to comment out
set belloff=all

" Set switching time between modes and cursor modes, may have to do slightly
" different based on os and terminal type
set timeoutlen=1000 ttimeoutlen=50
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"
