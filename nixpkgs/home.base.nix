{ config, pkgs, ... }:

let
  vimPlugins = with pkgs.vimPlugins; [
    nord-vim
    rainbow
    vim-airline
    vim-airline-themes
    vim-lsp
    async-vim
    asyncomplete-vim
    asyncomplete-lsp-vim
    editorconfig-vim
    vim-lsp-settings
  ];
in
{
  home.packages = with pkgs; [
    fd
    lsd
    zip
    unzip
    bc
    gh
    bat
    zellij
    starship
    fish
    lua-language-server
  ];

  home.file = {
    ".config/nvim/init.lua".source    = files/.config/nvim/init.lua;
    ".config/bat/config".source       = files/.config/bat/config;
    ".config/starship.toml".source    = files/.config/starship.toml;
    ".config/git/ignore".source       = files/.config/git/ignore;
    ".config/git/config".source       = files/.config/git/config;
    ".config/fish/config.fish".source = files/.config/fish/config.fish;
    ".config/fish/functions/fish_greeting.fish".source = files/.config/fish/functions/fish_greeting.fish;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      vim-vsnip
      nord-vim
    ];
  };

  programs.vim = {
    enable = true;
    plugins = vimPlugins;
    settings = {
      ignorecase = true;
      smartcase = true;
      number = true;
      hidden = true;
      mouse = "a";
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
    };
    extraConfig = ''
      set nocompatible
      filetype off

      set fileencoding=utf-8
      set encoding=utf-8
      scriptencoding=utf-8

      set showcmd

      set showmatch
      set list
      set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
      set ambiwidth=double

      set backspace=indent,eol,start
      set whichwrap=b,s,h,l,<,>,[,]
      set sidescroll=1
      set incsearch
      set wrapscan
      set hlsearch

      set confirm
      set autoread
      set noswapfile

      set visualbell t_vb=
      set noerrorbells

      function! s:clip_command()
        if has('win32') || !empty($WSL_DISTRO_NAME)
          return 'clip.exe'
        elseif has('mac')
          return 'pbcopy'
        elseif has('linux')
          if executable('xsel')
            return 'xsel -bi'
          elif executable('xclip')
            return 'xclip'=
          endif           =
        endif             =
        throw 'clipboard p=rogram not found'
      endfunction         =
      augroup Clipboard
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip_command(), @0) | endif
      augroup END

      colorscheme nord
      set termguicolors
      filetype plugin indent on

      " vim-airline
      let g:airline#extension#tabline#enabled = 1
      let g:airline_theme = 'nord'

      " rainbow
      let g:rainbow_actve = 1
    '';
  };
}
