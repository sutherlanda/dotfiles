{
  description = "Home-manager configuration";
  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # System management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim
    neovim-flake = {
      url = "path:./flakes/neovim";
    };

    # Mosh
    mosh-flake = {
      url = "path:./flakes/mosh";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    mosh-flake,
    neovim-flake,
    ...
  }: let
    pkgs = system:
      import nixpkgs {
        overlays = [
          neovim-flake.overlay.${system}
          mosh-flake.overlay.${system}
        ];
        config.allowUnfree = true;
        inherit system;
      };

    unstable-pkgs = system:
      import nixpkgs-unstable {
        overlays = [
          neovim-flake.overlay.${system}
          mosh-flake.overlay.${system}
        ];
        config.allowUnfree = true;
        inherit system;
      };
  in {
    homeConfigurations = {
      debian = let
        system = "x86_64-linux";
        pkgConfig = pkgs system;
        unstablePkgConfig = pkgs system;
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
                username = builtins.getEnv "USER";
                homeDirectory = builtins.getEnv "HOME";
                stateVersion = "24.05";
              };
            }
          ];
        };
      darwin-m1 = let
        system = "aarch64-darwin";
        pkgConfig = pkgs system;
        unstablePkgConfig = unstable-pkgs system;
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
                username = builtins.getEnv "USER";
                homeDirectory = builtins.getEnv "HOME";
                stateVersion = "24.05";
              };
            }
          ];
        };
    };
    darwin-m1 = self.homeConfigurations.darwin-m1.activationPackage;
    debian = self.homeConfigurations.debian.activationPackage;
  };
}
