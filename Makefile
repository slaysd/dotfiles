define FIX_SYNTAX
# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix
endef
export FIX_SYNTAX

init:
	@/bin/bash -c "sh <(curl -L https://nixos.org/nix/install)"

	if [ ! -d ~/.zplug ]; then \
		git clone https://github.com/zplug/zplug ${HOME}/.zplug; \
	fi
	mkdir -p ${HOME}/.config/nix
	echo "experimental-features = nix-command flakes" >> ${HOME}/.config/nix/nix.conf
sync:
	nix run home-manager -- switch --flake ${PWD}
gc:
	nix-collect-garbage --delete-older-than 30d
	nix run home-manager -- expire-generations -30days
fix-after-upgrade:
	echo "$${FIX_SYNTAX}" | sudo tee -a /etc/zshrc > /dev/null
