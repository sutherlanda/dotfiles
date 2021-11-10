{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    ag
    jq
    nodejs
    shellcheck
    stylua
    nodePackages.pyright
    nodePackages.typescript-language-server
    ripgrep
    fd
    tree-sitter
  ];

  home.file.".config/nvim/init.vim".source = ../config/neovim/init.vim;
  home.file.".config/nvim/lua".source = ../config/neovim/lua;
  xdg.configFile."nvim/parser/nix.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-nix}/parser";
  xdg.configFile."nvim/parser/lua.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-lua}/parser";
  xdg.configFile."nvim/parser/rust.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-rust}/parser";
  xdg.configFile."nvim/parser/c.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-c}/parser";
  xdg.configFile."nvim/parser/python.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-python}/parser";
  xdg.configFile."nvim/parser/bash.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-bash}/parser";
}
