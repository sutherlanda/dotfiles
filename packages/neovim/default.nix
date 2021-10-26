{ pkgs }:

let
  neovim = pkgs.neovim.override {
    vimAlias = true;
    configure = {
      customRC = ''
        lua << EOF
          ${builtins.readFile ./config/global.lua}
          ${builtins.readFile ./config/language-server.lua}
        EOF
      '';
      packages.myPlugins = with pkgs.vimPlugins; {
        start = [
          vim-sensible
          The_NERD_tree
          The_NERD_Commenter
          gruvbox
          surround
          lualine-nvim
          nvim-web-devicons
          fugitive
          fzf-vim
          vim-nix
          nvim-lspconfig
          (nvim-treesitter.withPlugins (
            plugins: with plugins; [
              tree-sitter-nix
              tree-sitter-rust
              tree-sitter-lua
              tree-sitter-bash
            ]
          ))
          completion-nvim
          vim-rooter
          lsp_extensions-nvim
          vim-glsl
        ];
        opt = [
        ];
      };
    };
  };
  neovimWrapper = pkgs.writeShellScriptBin "vim" ''
    ${neovim}/bin/nvim $@
  '';
in
  pkgs.symlinkJoin {
    name = "neovim";
    paths = [
      neovimWrapper
      pkgs.ag
      pkgs.jq
      pkgs.nodejs
    ];
  }
