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
  home.stateVersion = "22.11";
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
    xh
    dogdns
    gping
    zip
    unzip
    bc
  ];

  programs.bat = {
    enable = true;
    config = {
      paging = "never";
      theme = "Nord";
    };
  };

  programs.zellij = {
    enable = true;
    settings = {
      default_shell = "fish";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "[ ](bold blue)";
        error_symbol = "[ ](bold red)";
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
    ignores = [
      ".DS_Store"
      ".vscode"
      "[._]*.s[a-v][a-z]"
      "[._]*.sw[a-p]"
      "[._]s[a-rt-v][a-z]"
      "[._]ss[a-gi-z]"
      "[._]sw[a-p]"
      ".idea"
    ];
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

      function! s:clip_command()
        if has('win32') || !empty($WSL_DISTRO_NAME)
          return 'clip.exe'
        elseif has('mac')
          return 'pbcopy'
        elseif has('linux')
          if executable('xsel')
            return 'xsel -bi'
          elif executable('xclip')
            return 'xclip'
          endif
        endif
        throw 'clipboard program not found'
      endfunction
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

  programs.fish = {
    enable = true;
    shellAliases = {
      diff = "delta";
      ls = "lsd";
      cat = "bat";
    };
    functions = {
      cd = {
        body = ''
          if builtin cd $argv
            if type lsd > /dev/null 2>&1
              lsd
            else
              ls
            end
          end
        '';
      };
      fish_greeting = {
        body = ''
          echo "        /\\"
          echo "      _/./"
          echo "   ,-'    `-:.,-'/"
          echo "  > O )<)    _  ("
          echo "   `-._  _.:' `-.\\"
          echo "       `` \\;"
        '';
      };
    };
    shellInit = ''
      set -l nix_profile ~/.nix-profile/etc/profile.d/nix.fish
      if [ -e "$nix_profile" ]
        source "$nix_profile"
      end
      if not set -q NIX_PATH
        set -x NIX_PATH ~/.nix-defexpr/channels
      end

      set -x GPG_TTY (tty)
    '';
    loginShellInit = ''
        exec fish -i
    '';
    interactiveShellInit = ''
      set fish_color_error red --bold
      set fish_color_param white
      set fish_color_command cyan --bold
      set fish_color_autosuggestion green
      set fish_color_operator bryellow --bold
      set fish_color_comment green --bold
      set fish_color_search_match --background=magenta
      set fish_color_escape yellow --bold

      type starship > /dev/null 2>&1 && starship init fish | source

      function preexec --on-event fish_preexec
        printf "\e[1mexecute time: \e[4;33m%s\e[0m\n" (date '+%F (%a) %T')
      end

      set -x EDITOR vim
    '';
  };
}
