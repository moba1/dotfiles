{ pkgs, ... }:
{
  environment.systemPackages =
    [ pkgs.gnupg
    ];

  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  programs.gnupg.agent.enable = true;
}
