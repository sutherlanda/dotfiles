{
  description = "Builds mosh from source (latest). Used to enable truecolor.";

  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # Mosh
    mosh-src = { url = "github:mobile-shell/mosh"; flake = false; };
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, mosh-src, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        mosh-overlay = final: prev: with nixpkgs.legacyPackages.${system}; {
          mosh = final.stdenv.mkDerivation rec {
            name = "mosh";
            src = mosh-src;
            nativeBuildInputs = [ autoreconfHook pkg-config makeWrapper ];
            buildInputs = [
              protobuf
              ncurses
              zlib
              openssl
              bash-completion
            ]
            ++ (with perlPackages; [ perl IOTty ])
            ++ lib.optional final.stdenv.isLinux libutempter;
          };
        };
        pkgs = import nixpkgs { inherit system; overlays = [ mosh-overlay ]; };
      in
      rec {
        packages = with pkgs; {
          inherit mosh;
        };

        overlay = final: prev: with pkgs; {
          inherit mosh;
        };

        defaultPackage = packages.mosh;
      });
} 
