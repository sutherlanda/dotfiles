{ pkgs, config, ... }:
let

  vimPlugins = pkgs.vimPlugins // pkgs.callPackage ./custom-plugins.nix {};

in

{
  home.packages = with pkgs; [
    ag
    jq
    nodejs
    rnix-lsp
    rust-analyzer
    rustfmt
    shellcheck
    stylua
    nodePackages.pyright
    nodePackages.typescript-language-server
  ];

  programs.neovim = {
    enable = true;
    extraConfig = ''
      lua << EOF
        ${builtins.readFile ../../config/neovim/global.lua}
        ${builtins.readFile ../../config/neovim/language-server.lua}
      EOF
    '';
    plugins = with vimPlugins; [
      vim-sensible
      The_NERD_tree
      The_NERD_Commenter
      gruvbox-community
      surround
      lualine-nvim
      nvim-web-devicons
      fugitive
      fzf-vim
      vim-nix
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp_luasnip
      luasnip
      vim-rooter
      lsp_extensions-nvim
      vim-glsl
    ];
  };

  xdg.configFile."nvim/parser/nix.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-nix}/parser";
  xdg.configFile."nvim/parser/lua.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-lua}/parser";
  xdg.configFile."nvim/parser/rust.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-rust}/parser";
  xdg.configFile."nvim/parser/c.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-c}/parser";
  xdg.configFile."nvim/parser/python.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-python}/parser";
  xdg.configFile."nvim/parser/bash.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-bash}/parser";
}
