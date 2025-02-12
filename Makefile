init:
	@/bin/bash -c "sh <(curl -L https://nixos.org/nix/install)"

	if [ ! -d ~/.zplug ]; then \
		git clone https://github.com/zplug/zplug $HOME/.zplug; \
	fi
sync:
	nix run home-manager -- switch --flake ${PWD}
gc:
	nix-collect-garbage --delete-older-than 30d
	nix run home-manager -- expire-generations -30days
