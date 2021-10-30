{
  description = "Home-manager configuration";

  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # System management
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  
  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      nixpkgsConfig = {
        config = {
          allowUnfree = true;
          allowUnsupportedSystem = true;
        };
      };

    in

    {
      homeConfigurations = {
        debian = home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";
          stateVersion = "21.11";
          homeDirectory = "/home/andrew";
          username = "andrew";
          configuration = { pkgs, config, ...}: {
            nixpkgs = nixpkgsConfig;
            imports = [
              ./modules/cli.nix
              ./modules/neovim.nix
              ./modules/git.nix
              ./modules/scripts.nix
            ];
          };
        };
        darwin = home-manager.lib.homeManagerConfiguration {
          system = "x86_64-darwin";
          stateVersion = "21.11";
          homeDirectory = "/Users/andrewsutherland";
          username = "andrewsutherland";
          configuration = { pkgs, config, ... }: {
            nixpkgs = nixpkgsConfig;
            imports = [
              ./modules/cli.nix
              ./modules/neovim.nix
              ./modules/git.nix
              ./modules/scripts.nix
            ];
          };
        };
        nixos = home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";
          stateVersion = "21.11";
          homeDirectory = "/home/andrew";
          username = "andrew";
          configuration = { pkgs, config, ... }: {
            nixpkgs = nixpkgsConfig;
            imports = [
              ./modules/cli.nix
              ./modules/neovim.nix
              ./modules/git.nix
              ./modules/scripts.nix
            ];
          };
        };
      };
      darwin = self.homeConfigurations.darwin.activationPackage;
      debian = self.homeConfigurations.debian.activationPackage;
      nixos = self.homeConfigurations.nixos.activationPackage;
    };
}
