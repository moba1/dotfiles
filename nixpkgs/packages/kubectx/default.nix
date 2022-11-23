{ lib
, fetchFromGitHub
, buildGoModule
, installShellFiles
}:

buildGoModule rec {
  pname = "kubectx";
  version = "0.9.4";

  vendorSha256 = "sha256-4sQaqC0BOsDfWH3cHy2EMQNMq6qiAcbV+RwxCdcSxsg=";

  doCheck = false;

  ldflags = [ "-s" "-w" "-X main.version=v${version}" ];

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
