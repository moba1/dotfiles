{ pkgs, ... }:
{
  imports = [ <home-manager/nix-darwin> ];

  # set login shell configuration
  programs.fish.enable = true;
  services.nix-daemon.enable = true;
  home-manager.useGlobalPkgs = true;
  system.stateVersion = 4;

  environment.systemPackages =
    [ pkgs.gnupg
    ];
  programs.gnupg.agent.enable = true;
}
