{ config, pkgs, libs, ... }:

let

  neovim = import ../packages/neovim { inherit pkgs; };

in

{
  home.packages = [
    neovim
  ];
}
