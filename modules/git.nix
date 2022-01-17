{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    git
    git-crypt
  ];

  xdg.configFile."git/config".source = ../config/git/gitconfig;
}
