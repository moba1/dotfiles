{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "kubectx";
  version = "0.9.4";
  src = pkgs.fetchFromGitHub {
    owner = "ahmetb";
    repo = "kubectx";
    rev = "v${version}";
    sha256 = "WY0zFt76mvdzk/s2Rzqys8n+DVw6qg7V6Y8JncOUVCM=";
  };

  phases = [ "installPhase" "postInstall" ];

  installPhase = ''
    mkdir -p $out/bin
    install -Dm555 $src/kubectx $out/bin/kubectx
    install -Dm555 $src/kubens $out/bin/kubens
  '';

  nativeBuildInputs = [ pkgs.installShellFiles ];

  postInstall = ''
    installShellCompletion \
      --cmd kubectx \
      --fish $src/completion/kubectx.fish
    installShellCompletion \
      --cmd kubens \
      --fish $src/completion/kubens.fish
  '';
}
