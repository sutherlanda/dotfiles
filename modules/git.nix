{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    git
    git-crypt
    gh
  ];

  xdg.configFile."git/config".source = ../config/git/gitconfig;
}
