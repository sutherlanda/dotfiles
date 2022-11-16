{
  description = "Home-manager configuration";

  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs";

    # System management
    home-manager.url = "github:nix-community/home-manager?rev=f520832a47dbc24d1e2c4e4b9a3dbe910777d1a2";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Neovim
    neovim-flake = {
      url = "github:sutherlanda/flakes?dir=neovim";
    };

    # Mosh
    mosh-flake = {
      url = "github:sutherlanda/flakes?dir=mosh";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    # Node modules
    node-modules-flake = {
      url = "github:sutherlanda/flakes?dir=node_modules";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    # Other
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, mosh-flake, neovim-flake, node-modules-flake, ... }:
    let
      pkgs = system: import nixpkgs {
        overlays = [
          neovim-flake.overlay.${system}
          mosh-flake.overlay.${system}
          node-modules-flake.overlay.${system}
        ];
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
