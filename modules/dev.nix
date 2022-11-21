{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    neovim
    silver-searcher
    jq
    yarn
    nodejs-16_x
    nodePackages.pyright
    nodePackages.typescript-language-server
    nodePackages.bash-language-server
    nodePackages.node2nix
    nodePackages.eslint_d
    nodePackages.prettier
    ripgrep
    fd
    tree-sitter
    rnix-lsp
    gopls
    prettierd # From node-modules-flake
    google-cloud-sdk
    postgresql
    python2
    python39Packages.autopep8
    ghc
    gdb
  ];

  xdg.configFile."nvim/parser/nix.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-nix}/parser";
  xdg.configFile."nvim/parser/lua.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-lua}/parser";
  xdg.configFile."nvim/parser/rust.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-rust}/parser";
  xdg.configFile."nvim/parser/c.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-c}/parser";
  xdg.configFile."nvim/parser/python.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-python}/parser";
  xdg.configFile."nvim/parser/bash.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-bash}/parser";
}
