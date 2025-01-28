{
  description = "Jeeseung's nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: let
    pkgs = import nixpkgs { system = "aarch64-darwin"; };
  in {
    homeConfigurations = {
      user = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        modules = [ ./zsh.nix ];
      };
    };
  };
}
