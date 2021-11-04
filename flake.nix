{
  description = "Home-manager configuration";

  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs?rev=7b77cca268d1c0de2c22c13baf19654a47abe562";

    # System management
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };
  
  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let

      overlays = [ inputs.neovim-nightly-overlay.overlay ];

      nixpkgsConfig = {
        overlays = overlays;
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
              ./programs/neovim
              ./modules/git.nix
              ./modules/scripts.nix
            ];
          };
        };
        darwin-intel = home-manager.lib.homeManagerConfiguration {
          system = "x86_64-darwin";
          stateVersion = "21.11";
          homeDirectory = "/Users/andrewsutherland";
          username = "andrewsutherland";
          configuration = { pkgs, config, ... }: {
            nixpkgs = nixpkgsConfig;
            imports = [
              ./modules/cli.nix
              ./programs/neovim
              ./modules/git.nix
              ./modules/scripts.nix
            ];
          };
        };
        darwin-m1 = home-manager.lib.homeManagerConfiguration {
          system = "aarch64-darwin";
          stateVersion = "21.11";
          homeDirectory = "/Users/andrewsutherland";
          username = "andrewsutherland";
          configuration = { pkgs, config, ... }: {
            nixpkgs = nixpkgsConfig;
            imports = [
              ./modules/cli.nix
              ./programs/neovim
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
              ./programs/neovim
              ./modules/git.nix
              ./modules/scripts.nix
            ];
          };
        };
      };
      darwin-intel = self.homeConfigurations.darwin-intel.activationPackage;
      darwin-m1 = self.homeConfigurations.darwin-m1.activationPackage;
      debian = self.homeConfigurations.debian.activationPackage;
      nixos = self.homeConfigurations.nixos.activationPackage;
    };
}
