{ config, pkgs, ... }:

let
  vim-lsp-settings = pkgs.vimUtils.buildVimPlugin {
    name = "vim-lsp-settings";
    src = pkgs.fetchFromGitHub {
      owner = "mattn";
      repo = "vim-lsp-settings";
      rev = "bde172e55b1f4d169b4a1219dca23761ab6e80d9";
      sha256 = "0n674fa1dhvm3sq7pqri7cs3ggbf2g1xpych91gd7k9xavv1bds8";
    };
    buildPhase = ":"; # ignore shellcheck check
  };
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
  home.username = "moba";
  home.homeDirectory = "/home/moba";
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    fd
    lsd
    ripgrep
    procs
    delta
    sd
    tokei
    broot
    fish
  ];

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
      package.disabled = true;
      container.disabled = true;
      directory.truncation_symbol = "…/";
    };
  };

  programs.git = {
    enable = true;
    userName = "moba1";
    userEmail = "moba2@protonmail.com";
    ignores = [ ".DS_Store" ];
    extraConfig = {
      init.defaultBranch = "main";
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
      delta.features = "decorations";
      delta.line-numbers = "true";
      delta.side-by-side = "true";
      gpg.program = "gpg";
      commit.gpgsign = true;
      tag.gpgsign = true;
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

      if !empty($WSL_DISTRO_NAME)
        augroup WSLYank
          autocmd!
          autocmd TextYankPost * if v:event.operator ==# 'y' | call system('/mnt/c/Windows/System32/clip.exe', @0) | endif
        augroup END
      elseif has('mac')
        augroup MacYank
          autocmd!
          autocmd TextYankPost * if v:event.operator ==# 'y' | call system('/usr/bin/pbcopy', @0) | endif
        augroup END
      endif

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
