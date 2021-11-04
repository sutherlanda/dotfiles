{
  description = "Development enrivonment for JavaScript/TypeScript";

  inputs =  {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      shell = pkgs.mkShell {
        buildInputs = with pkgs; [ cargo ];
      };
    in {
      packages = {
        shell = shell;
      };

      devShell = shell; 
    });
}

