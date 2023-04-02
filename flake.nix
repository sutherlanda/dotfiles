{
  description = "Home-manager configuration";
  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs";

    # System management
    home-manager.url = "github:nix-community/home-manager";

    # Neovim
    neovim-flake = {
      url = "path:./flakes/neovim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Node modules
    node-modules-flake = {
      url = "path:./flakes/node_modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nixpkgs, home-manager, neovim-flake, node-modules-flake, ... }:
    let
      pkgs = system: import nixpkgs {
        overlays = [
          neovim-flake.outputs.overlay.${system}
          node-modules-flake.overlay.${system}
        ];
        config.allowUnfree = true;
        inherit system;
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
            pkgs = pkgConfig;
            modules = [
              ./modules/cli.nix
              ./modules/git.nix
              ./modules/scripts.nix
              ./modules/rust.nix
              ./modules/dev.nix
              {
                home = {
                  username = "andrew";
                  homeDirectory = "/home/andrew";
                  stateVersion = "22.11";
                };
              }
            ];
          };
        darwin-m1 =
          let
            system = "aarch64-darwin";
            pkgConfig = pkgs system;
          in
          home-manager.lib.homeManagerConfiguration {
            pkgs = pkgConfig;
            modules = [
              ./modules/cli.nix
              ./modules/git.nix
              ./modules/scripts.nix
              ./modules/rust.nix
              ./modules/dev.nix
              {
                home = {
                  username = "andrew";
                  homeDirectory = "/Users/andrew";
                  stateVersion = "22.11";
                };
              }
            ];
          };
      };
      darwin-m1 = self.homeConfigurations.darwin-m1.activationPackage;
      debian = self.homeConfigurations.debian.activationPackage;
    };
}
