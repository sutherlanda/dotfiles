{
  description = "Home-manager configuration";

  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs?rev=7b77cca268d1c0de2c22c13baf19654a47abe562";

    # System management
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Neovim
    neovim-flake = {
      url = "path:/Users/andrewsutherland/projects/home/flakes/neovim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    # Other
    flake-utils.url = "github:numtide/flake-utils";
  };
  
  outputs = inputs@{ self, nixpkgs, home-manager, neovim-flake, ... }:
    let

      pkgs = system: {  
        overlays = [ neovim-flake.overlay.${system} ];
        config = {
          allowBroken = true;
          allowUnfree = true;
          allowUnsupportedSystem = true;
        };
      };

    in

    {
      homeConfigurations = {
        debian = 
	  let
	    system = "x86_64-linux";
	    pkgConfig = pkgs system;
	  in
	    home-manager.lib.homeManagerConfiguration {
	      inherit system;
              stateVersion = "21.11";
              homeDirectory = "/home/andrew";
              username = "andrew";
              configuration = { config, ...}: {
                nixpkgs = pkgConfig;
                imports = [
                  ./modules/cli.nix
                  ./modules/git.nix
                  ./modules/scripts.nix
                  ./modules/rust.nix
                  ./modules/editing.nix
                ];
              };
            };
        darwin-m1 = 
	  let
	    system = "aarch64-darwin";
	    pkgConfig = pkgs system;
	  in
	    home-manager.lib.homeManagerConfiguration {
	      inherit system;
              stateVersion = "21.11";
              homeDirectory = "/Users/andrewsutherland";
              username = "andrewsutherland";
              configuration = { pkgs, config, ... }: {
                nixpkgs = pkgConfig; 
                home.packages = [ pkgs.neovim ];
                imports = [
                  ./modules/cli.nix
                  ./modules/git.nix
                  ./modules/scripts.nix
                  ./modules/rust.nix
                  ./modules/editing.nix
                ];
              };
            };
      };
      darwin-m1 = self.homeConfigurations.darwin-m1.activationPackage;
      debian = self.homeConfigurations.debian.activationPackage;
    };
}
