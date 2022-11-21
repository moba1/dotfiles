NIX_PATH ?= ~/.nix-defexpr/channels

.PHONY: all
all:
	mkdir -p ~/.config
	ln -sfn $(PWD)/nixpkgs ~/.config/nixpkgs
	nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
	nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	nix-channel --update
	nix-shell '<home-manager>' -A install
