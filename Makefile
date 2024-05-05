NIX_PATH ?= $(HOME)/.nix-defexpr/channels
CURRENT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONY: all
all: setup-nix-channel
	-cp ~/.config/home-manager/home.nix /tmp/home.nix
	-if [ -L ~/.config/home-manager ]; then \
	    rm -f ~/.config/home-manager; \
	else \
	    rm -rf ~/.config/home-manager; \
	fi
	nix-shell --run sh '<home-manager>' -A install
	-if [ ! -e /tmp/home.nix ]; then \
	    cp ~/.config/home-manager/home.nix /tmp/home.nix; \
	fi
	rm -rf ~/.config/home-manager
	ln -sf "$(CURRENT_DIR)/nixpkgs" ~/.config/home-manager
	mv /tmp/home.nix ~/.config/home-manager/

.PHONY: setup-nix-channel
setup-nix-channel:
	nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	nix-channel --update



.PHONY: osx
osx:
	nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
	./result/bin/darwin-installer
