{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnupg
  ];

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "tty";
    maxCacheTtl = 86400;
    defaultCacheTtl = 86400;
  };
}
