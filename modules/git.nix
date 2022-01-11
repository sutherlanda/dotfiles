{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    git
    git-crypt
  ];

  xdg.configFile."git/config".source = ../config/git/gitconfig;
  xdg.configFile."git/zesty/config".source = ../config/git/zesty/gitconfig;
}
