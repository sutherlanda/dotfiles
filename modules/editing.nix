{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    neovim
    ag
    jq
    nodePackages.pyright
    nodePackages.typescript-language-server
    nodePackages.bash-language-server
    nodePackages.node2nix
    nodePackages.prettier
    ripgrep
    fd
    tree-sitter
    rnix-lsp
    prettierd
    gopls
  ];

  xdg.configFile."nvim/parser/nix.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-nix}/parser";
  xdg.configFile."nvim/parser/lua.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-lua}/parser";
  xdg.configFile."nvim/parser/rust.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-rust}/parser";
  xdg.configFile."nvim/parser/c.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-c}/parser";
  xdg.configFile."nvim/parser/python.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-python}/parser";
  xdg.configFile."nvim/parser/bash.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-bash}/parser";
}
