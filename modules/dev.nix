{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    neovim
    silver-searcher
    jq
    yarn
    nodejs-18_x
    pyright
    nodePackages.typescript-language-server
    nodePackages.bash-language-server
    nodePackages.node2nix
    nodePackages.nodemon
    alejandra
    rustfmt
    stylua
    eslint_d
    prettierd
    ripgrep
    fd
    tree-sitter
    gopls
    postgresql
    coreutils
    jre8
    ripgrep
    yq
    zlib
    luajit
  ];
}
