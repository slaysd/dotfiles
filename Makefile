init:
	@/bin/bash -c "sh <(curl -L https://nixos.org/nix/install)"
sync:
	nix run home-manager -- switch --flake ${PWD}
gc:
	nix-collect-garbage --delete-older-than 30d
	nix run home-manager -- expire-generations -30days
