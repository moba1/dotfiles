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
  call dein#add('rust-lang/rust.vim')
  call dein#add('kchmck/vim-coffee-script')
  call dein#add('Xuyuanp/nerdtree-git-plugin')
  call dein#add('posva/vim-vue')
  call dein#add('digitaltoad/vim-pug')
  call dein#add('wavded/vim-stylus')
  call dein#add('scrooloose/nerdcommenter')

  call dein#end()
  call dein#save_state()
  if dein#check_install()
    call dein#install()
  endif
endif



filetype plugin indent on
syntax enable

map <C-b> :NERDTreeToggle<CR>
map <C-g> :NERDTreeFind<CR>
map <C-j> :resize +5<CR>
map <C-k> :resize -5<CR>
map <C-h> :vertical resize -5<CR>
map <C-l> :vertical resize +5<CR>

" for ocaml
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute 'set rtp+=' . g:opamshare . '/merlin/vim'

