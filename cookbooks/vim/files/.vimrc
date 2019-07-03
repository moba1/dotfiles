set nocompatible
set fileencoding=utf-8

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

" environment
set clipboard=unnamed,unnamedplus,autoselect
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
  call dein#add('vim-python/python-syntax')
  call dein#add('dag/vim-fish')
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('ConradIrwin/vim-bracketed-paste')

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
map <C-u> :undo<CR>
imap <C-c> <esc>
noremap! <C-c> <esc>

" for NERD commenter
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign='left'
let mapleader=","

" for python-syntax
let g:python_highlight_all = 1

" for reStructuredText
autocmd BufNewFile,BufRead *.rst highlight OverLength ctermbg=red ctermfg=white guibg=#592929
autocmd BufNewFile,BufRead *.rst match OverLength /\%71v.\+/

