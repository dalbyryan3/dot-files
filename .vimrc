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
Plugin 'https://github.com/tpope/vim-commentary.git'
" sleuth for tabs/spaces detection
Plugin 'https://github.com/tpope/vim-sleuth.git'
" one Dark theme
Plugin 'https://github.com/joshdick/onedark.vim.git'
" fugitive for git integration
Plugin 'https://github.com/tpope/vim-fugitive.git'
" obsession for vim session management
Plugin 'https://github.com/tpope/vim-obsession.git'
" surround for useful surround commands
Plugin 'https://github.com/tpope/vim-surround.git'
" repeat for better repeat functionality
Plugin 'https://github.com/tpope/vim-repeat.git'
" Unimpaired for common ex commands
Plugin 'https://github.com/tpope/vim-unimpaired.git'
" eunuch for common unix shell commands
Plugin 'https://github.com/tpope/vim-eunuch.git'
" vinegar for better directory navigation
Plugin 'https://github.com/tpope/vim-vinegar.git'
" flagship for status and tab line
Plugin 'https://github.com/tpope/vim-flagship.git'
" tbone for tmux integration
Plugin 'https://github.com/tpope/vim-tbone.git'
" rsi for unix cli-like navigation in certain cases
Plugin 'https://github.com/tpope/vim-rsi.git'
" endwise to add certain end structures automatically
Plugin 'https://github.com/tpope/vim-endwise.git'
" fzf for fuzzy search (also integrates with ag)
Plugin 'https://github.com/junegunn/fzf.git'
Plugin 'https://github.com/junegunn/fzf.vim.git'
" vim-better-whitespace for better whitespace highlighting
Plugin 'https://github.com/ntpeters/vim-better-whitespace.git'
" Kotlin syntax highlighting
Plugin 'https://github.com/udalov/kotlin-vim.git'

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
" Turn on incremental search
set incsearch
" Case insensitive searches
set ignorecase
" Search will be case sensitive if it contains an uppercase letter
set smartcase
" Set tabs as spaces initially, sleuth will adjust based on file
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
" Allow for switching between edited buffers
set hidden
" Turn off flashing/visual bell, may need newer Vim version (7.4+) so may need to comment out
set belloff=all
" Allow backpace of previously inserted characters
set backspace=indent,eol,start
" Only be able to select text and not line numbers
set mouse+=a
" Prevent continuation of comments to the next line
autocmd FileType * set formatoptions-=c formatoptions-=r formatoptions-=o
" Change comment styles for certain filetypes
autocmd FileType c,cpp set commentstring=//\ %s
" Add ruler
set colorcolumn=80
" For status and tab line to persist
set laststatus=2
set showtabline=2
set guioptions-=e

" Set switching time between modes and cursor modes, may have to do slightly
" different based on os and terminal type
set timeoutlen=1000 ttimeoutlen=50
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"
