{
  description = "Home-manager configuration";
  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs";

    # System management
    home-manager.url = "github:nix-community/home-manager";

    # Neovim
    neovim-flake = {
      url = "github:sutherlanda/dotfiles?dir=flakes/neovim";
    };

    # Mosh
    mosh-flake = {
      url = "github:sutherlanda/dotfiles?dir=flakes/mosh";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, mosh-flake, neovim-flake, ... }:
    let
      pkgs = system: import nixpkgs {
        overlays = [
          neovim-flake.overlay.${system}
          mosh-flake.overlay.${system}
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
