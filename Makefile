NIX_PATH ?= $(HOME)/.nix-defexpr/channels
CURRENT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONY: all
all: setup-dotfiles setup-nix-channel

.PHONY: setup-dotfiles
setup-dotfiles:
	mkdir -p ~/.config/home-manager
	ln -sf $(CURRENT_DIR)/nixpkgs/home.base.nix ~/.config/home-manager/home.base.nix
	ln -sf $(CURRENT_DIR)/nixpkgs/files ~/.config/home-manager

.PHONY: setup-nix-channel
setup-nix-channel:
	nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	nix-channel --update
	nix-shell --run sh '<home-manager>' -A install

.PHONY: osx
osx:
	nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
	./result/bin/darwin-installer
