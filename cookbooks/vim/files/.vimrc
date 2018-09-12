set nocompatible

" status line
set showcmd
set cursorline
set laststatus=2
set cmdheight=2

" view
set showmatch
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set ambiwidth=double
let g:rainbow_active = 1

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

" environment
set clipboard=unnamed,unnamedplus
set mouse=a

" bell
set visualbell t_vb=
set noerrorbells

" space
set expandtab
set tabstop=2
set shiftwidth=2

" setup dein
set runtimepath+=~/.vim/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.vim/.cache/dein')
  call dein#begin('~/.vim/.cache/dein')

  call dein#add('~/.vim/.cache/dein')
  call dein#add('luochen1990/rainbow')
  call dein#add('scrooloose/nerdtree')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

map <C-n> :NERDTreeToggle<CR>
