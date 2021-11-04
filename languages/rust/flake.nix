{
  description = "Development enrivonment for Rust";

  inputs =  {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      shell = pkgs.mkShell {
        buildInputs = with pkgs; [ rustc cargo rustfmt ];
      };
    in {
      packages = {
        shell = shell;
      };

      devShell = shell;
    });
}
