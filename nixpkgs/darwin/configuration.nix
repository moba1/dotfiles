{ pkgs, ... }:
{
  imports = [ <home-manager/nix-darwin> ~/.nixpkgs/darwin-configuration.nix ];

  # set login shell configuration
  programs.fish.enable = true;
  home-manager.useGlobalPkgs = true;

  environment.systemPackages =
    [ pkgs.gnupg
    ];
  programs.gnupg.agent.enable = true;
}
