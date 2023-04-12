{ pkgs, ... }:
{
  imports = [ <home-manager/nix-darwin> ];

  # set login shell configuration
  programs.fish.enable = true;
  home-manager.useGlobalPkgs = true;

  environment.systemPackages =
    [ pkgs.gnupg
    ];
  programs.gnupg.agent.enable = true;

  services.nix-daemon.enable = true;
}
