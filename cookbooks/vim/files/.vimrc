set nocompatible
filetype off
set fileencoding=utf-8
set encoding=utf-8

" status line
set showcmd
set laststatus=2
set cmdheight=2

" view
set showmatch
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set ambiwidth=double
set nu
let g:rainbow_active = 1
set statusline=%F%m%r%h%w%=\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%lL,%vC][%p%%]\ [LEN=%L]

" cursor
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
set sidescroll=1

" seaerch
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

" File
set hidden
set confirm
set autoread
set noswapfile

" bell
set visualbell t_vb=
set noerrorbells

" space
set expandtab
set tabstop=2
set shiftwidth=2

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'luochen1990/rainbow'
Plugin 'rust-lang/rust.vim'
Plugin 'preservim/nerdtree'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ryanoasis/vim-devicons'
call vundle#end()
filetype plugin indent on
syntax enable

map <C-b> :NERDTreeToggle<CR>
imap <C-c> <esc>
noremap! <C-c> <esc>

" for NERD commenter
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign='left'
let mapleader=","

" for python-syntax
let g:python_highlight_all = 1

" clipboard
set clipboard+=unnamedplus

" mouse
set mouse=a

"set termguicolors
"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark
colorscheme solarized
