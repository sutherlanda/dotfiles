{
  description = "Home-manager configuration";

  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs";

    # System management
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Neovim
    neovim-flake = {
    url = "github:sutherlanda/flakes?dir=neovim";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-utils.follows = "flake-utils";
    };

    # Mosh
        mosh-flake = {
    url = "github:sutherlanda/flakes?dir=mosh";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-utils.follows = "flake-utils";
    };

    # Prettierd
    prettierd-flake = {
    url = "github:sutherlanda/flakes?dir=prettierd";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-utils.follows = "flake-utils";
    };

    # Other
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, mosh-flake, neovim-flake, prettierd-flake, ... }:
    let

      pkgs = system: {
        overlays = [
        neovim-flake.overlay.${system}
        mosh-flake.overlay.${system}
        prettierd-flake.overlay.${system}
        ];
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
            configuration = { config, ... }: {
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
            homeDirectory = "/Users/andrew";
            username = "andrew";
            configuration = { pkgs, config, ... }: {
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
      };
      darwin-m1 = self.homeConfigurations.darwin-m1.activationPackage;
      debian = self.homeConfigurations.debian.activationPackage;
    };
}
