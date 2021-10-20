syntax enable

filetype plugin indent on

set completeopt=menuone,noinsert,noselect

set shortmess+=c

lua <<EOF

vim.o.background = "dark"

vim.cmd([[colorscheme gruvbox]])

local nvim_lsp = require'lspconfig'

local on_attach = function(client)
  require'completion'.on_attach(client)
end

nvim_lsp.rust_analyzer.setup({ on_attach = on_attach })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = false,
	signs = true,
    	update_in_insert = false
  }
)
EOF
