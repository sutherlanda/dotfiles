{
  description = "Builds the prettierd node package - a faster, daemonized version of prettier";

  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # prettierd
    prettierd-src = { url = "github:fsouza/prettierd"; flake = false; };
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, prettierd-src, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        nodePkgs = import ./default.nix { pkgs = nixpkgs.legacyPackages.${system}; };
        prettierd-overlay = final: prev: with nixpkgs.legacyPackages.${system}; {
          prettierd = nodePkgs."@fsouza/prettierd";
        };
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ prettierd-overlay ];
        };
      in
      rec {
        packages = with pkgs; {
          inherit prettierd;
        };

        overlay = final: prev: with pkgs; {
          inherit prettierd;
        };

        defaultPackage = packages.prettierd;
      });
} 