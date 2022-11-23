# Partially referenced from nixpkgs:
#
# Copyright (c) 2003-2022 Eelco Dolstra and the Nixpkgs/NixOS contributors
# Released under the MIT license
# https://opensource.org/licenses/mit-license.php
{ fetchFromGitHub
, buildGoModule
, installShellFiles
}:

buildGoModule rec {
  pname = "kubectx";
  version = "0.9.4";

  vendorSha256 = "sha256-p4KUBmJw6hWG1J2qwg4QBbh6Vo1cr/HQz0IqytIDJjU=";

  doCheck = false;

  ldflags = [ "-s" "-w" "-X main.version=v${version}" ];

  patches = [
    ./bump-golang-x-sys.patch
  ];

  src = fetchFromGitHub {
    owner = "ahmetb";
    repo = "kubectx";
    rev = "v${version}";
    sha256 = "WY0zFt76mvdzk/s2Rzqys8n+DVw6qg7V6Y8JncOUVCM=";
  };

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    installShellCompletion completion/*
  '';
}
