init:
	sh <(curl -L https://nixos.org/nix/install)
sync:
	nix run home-manager -- switch --flake ${PWD}
	@echo "Reloading shell profile..."
	@exec $$SHELL -l
gc:
	nix-collect-garbage --delete-older-than 30d
