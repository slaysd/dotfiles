init:
	@/bin/bash -c "sh <(curl -L https://nixos.org/nix/install)"
sync:
	nix run home-manager -- switch --flake ${PWD}
	
	@zplug_path=$(shell nix eval --raw .#homeConfigurations.user.pkgs.zplug) && \
	rm -rf ~/.zplug/bin && \
	ln -s $$zplug_path/share/zplug/bin ~/.zplug/bin

	@echo "Reloading shell..."
	@exec $$SHELL -l
gc:
	nix-collect-garbage --delete-older-than 30d
	nix run home-manager -- expire-generations -30days
