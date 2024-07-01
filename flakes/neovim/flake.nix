{
  description = "Andrew Sutherland's custom neovim.";
  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    ### Plugins ###

    # LSP
    nvim-lspconfig = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };
    null-ls = {
      url = "github:jose-elias-alvarez/null-ls.nvim";
      flake = false;
    };
    rust-tools = {
      url = "github:simrat39/rust-tools.nvim";
      flake = false;
    };

    # Syntax highlighting
    vim-nix = {
      url = "github:LnL7/vim-nix";
      flake = false;
    };
    nvim-treesitter = {
      url = "github:nvim-treesitter/nvim-treesitter";
      flake = false;
    };

    # Formatting
    formatter-nvim = {
      url = "github:mhartington/formatter.nvim";
      flake = false;
    };
    conform-nvim = {
      url = "github:stevearc/conform.nvim";
      flake = false;
    };
    stylish-haskell = {
      url = "github:haskell/stylish-haskell";
      flake = false;
    };
    vim-stylish-haskell = {
      url = "github:nbouscal/vim-stylish-haskell";
      flake = false;
    };

    # Themes
    tokyonight-nvim = {
      url = "github:folke/tokyonight.nvim";
      flake = false;
    };
    nightfox-nvim = {
      url = "github:EdenEast/nightfox.nvim";
      flake = false;
    };
    gruvbox-nvim = {
      url = "github:ellisonleao/gruvbox.nvim";
      flake = false;
    };
    nvim-web-devicons = {
      url = "github:nvim-tree/nvim-web-devicons";
      flake = false;
    };

    # NERD
    nerd-commenter = {
      url = "github:preservim/nerdcommenter";
      flake = false;
    };

    # nvim-tree
    nvim-tree = {
      url = "github:kyazdani42/nvim-tree.lua";
      flake = false;
    };

    # Completion
    nvim-cmp = {
      url = "github:hrsh7th/nvim-cmp";
      flake = false;
    };
    cmp-nvim-lsp = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };
    cmp-path = {
      url = "github:hrsh7th/cmp-path";
      flake = false;
    };
    cmp-buffer = {
      url = "github:hrsh7th/cmp-buffer";
      flake = false;
    };
    cmp-cmdline = {
      url = "github:hrsh7th/cmp-cmdline";
      flake = false;
    };
    luasnip = {
      url = "github:L3MON4D3/LuaSnip";
      flake = false;
    };

    # Git
    gitsigns = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };
    copilot = {
      url = "github:github/copilot.vim";
      flake = false;
    };

    # Misc
    lualine-nvim = {
      url = "github:nvim-lualine/lualine.nvim";
      flake = false;
    };
    vim-rooter = {
      url = "github:airblade/vim-rooter";
      flake = false;
    };
    vim-surround = {
      url = "github:tpope/vim-surround";
      flake = false;
    };
    fugitive = {
      url = "github:tpope/vim-fugitive";
      flake = false;
    };
    vim-sensible = {
      url = "github:tpope/vim-sensible";
      flake = false;
    };
    telescope = {
      url = "github:nvim-telescope/telescope.nvim";
      flake = false;
    };
    telescope-fzy-native = {
      url = "github:nvim-telescope/telescope-fzy-native.nvim";
      flake = false;
    };
    plenary = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
    vim-python-virtualenv = {
      url = "github:sansyrox/vim-python-virtualenv";
      flake = false;
    };
    smooth-scroll = {
      url = "github:karb94/neoscroll.nvim";
      flake = false;
    };
    alpha-nvim = {
      url = "github:goolord/alpha-nvim";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };

      buildPlugin = name:
        pkgs.vimUtils.buildVimPlugin {
          pname = name;
          version = "master";
          src = builtins.getAttr name inputs;
        };

      plugins = [
        "nvim-lspconfig"
        "null-ls"
        "rust-tools"
        "vim-nix"
        "nvim-treesitter"
        "formatter-nvim"
        "conform-nvim"
        "stylish-haskell"
        "tokyonight-nvim"
        "nightfox-nvim"
        "gruvbox-nvim"
        "nvim-web-devicons"
        "vim-stylish-haskell"
        "nerd-commenter"
        "nvim-tree"
        "nvim-cmp"
        "cmp-nvim-lsp"
        "cmp-path"
        "cmp-buffer"
        "cmp-cmdline"
        "gitsigns"
        "copilot"
        "luasnip"
        "lualine-nvim"
        "vim-rooter"
        "vim-surround"
        "fugitive"
        "vim-sensible"
        "telescope"
        "telescope-fzy-native"
        "plenary"
        "vim-python-virtualenv"
        "smooth-scroll"
        "alpha-nvim"
      ];

      nvim-plugintree = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
        p.c
        p.lua
        p.nix
        p.bash
        p.cpp
        p.json
        p.python
        p.markdown
      ]);

      treesitter-parsers = pkgs.symlinkJoin {
        name = "treesitter-parsers";
        paths = nvim-plugintree.dependencies;
      };

      neovim = pkgs.neovim.override {
        vimAlias = true;
        configure = {
          customRC = ''
            luafile ${config/lua/global.lua}
            luafile ${config/lua/lsp.lua}
          '';
          packages.myVimPackage = {
            start =
              map buildPlugin plugins
              ++ [
                nvim-plugintree
              ];
          };
        };
      };
    in rec {
      packages = with pkgs; {
        inherit neovim;
        config = ./config;
      };

      overlay = final: prev: {
        neovim = packages.neovim;
      };

      defaultPackage = packages.neovim;
    });
}
