{ config, pkgs, ... }:

let
  additionalPackages =
  if builtins.pathExists ./additional-packages.nix then
    (import ./additional-packages.nix { pkgs = pkgs; }).pkgs
  else
    [];
  vimPlugins = with pkgs.vimPlugins; [
    nord-vim
    rainbow
    vim-airline
    vim-airline-themes
  ];
in
{
  home.username = "moba";
  home.homeDirectory = "/home/moba";
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;

  home.packages = additionalPackages ++ (with pkgs; [
    fd
    lsd
    ripgrep
    procs
    delta
    sd
    tokei
    broot
  ]);

  programs.bat = {
    enable = true;
    config = {
      paging = "never";
      theme = "Nord";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "[](bold blue)";
        error_symbol = "[](bold red)";
      };
      package = {
        disabled = true;
      };
      container = {
        disabled = true;
      };
      directory = {
        truncation_symbol = "…/";
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "moba1";
    userEmail = "moba2@protonmail.com";
    ignores = [ ".DS_Store" ];
    extraConfig = {
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
      delta.features = "decorations";
      delta.line-numbers = "true";
      delta.side-by-side = "true";
    };
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

      set clipboard=unnamedplus,unnamed

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

  xdg.configFile."fish/config.fish".source = config.lib.file.mkOutOfStoreSymlink ../assets/fish/config.fish;
  xdg.configFile."fish/functions/cd.fish".source = config.lib.file.mkOutOfStoreSymlink ../assets/fish/functions/cd.fish;
  xdg.configFile."fish/functions/fish_greeting.fish".source = config.lib.file.mkOutOfStoreSymlink ../assets/fish/functions/fish_greeting.fish;
}
