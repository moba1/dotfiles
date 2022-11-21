{ pkgs, ... }:

{
  pkgs = [
    pkgs.awscli2
    pkgs.aws-vault
  ];
}
