{ config, pkgs, ... }:
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
      lualine-nvim
      nvim-web-devicons
    ];
  };
}
