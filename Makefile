NIX_PATH ?= $(HOME)/.nix-defexpr/channels

.PHONY: all
all:
	mkdir -p ~/.config
	ln -sfn $(PWD)/nixpkgs ~/.config/nixpkgs
	nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
	nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	nix-channel --update
	env "NIX_PATH=$(NIX_PATH)" nix-shell '<home-manager>' -A install
