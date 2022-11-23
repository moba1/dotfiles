{ pkgs ? import <nixpkgs> {}
, ...
}:
{
  kubectx = import ./kubectx {
    fetchFromGitHub = pkgs.fetchFromGitHub;
    buildGoModule = pkgs.buildGoModule;
    installShellFiles = pkgs.installShellFiles;
  };
}
