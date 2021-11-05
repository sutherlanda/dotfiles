vim.opt.incsearch = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.hidden = true
vim.opt.updatetime = 300
vim.opt.hlsearch = true
vim.opt.foldenable = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.g.gruvbox_italic = 1
vim.g.gruvbox_underline = 1
vim.g.gruvbox_undercurl = 1
vim.g.gruvbox_contrast_dark = 'hard'
vim.cmd([[colorscheme gruvbox]])
vim.g.rooter_patterns = {'.git', '.git/', 'shell.sh', 'shell.nix'}
vim.g.rooter_silent_chdir = 1
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

-- Lualine
require'lualine'.setup({
  options = {
    icons_enabled = true,
    theme = 'gruvbox'
  },
  sections = {
    lualine_c = {
      {
        'filename',
        file_status = true,
        full_path = true
      },
    },
    lualine_y = {
      {
        'diagnostics',
        sources = {'nvim_lsp'}
      }
    }
  }
})

-- Silver-search with grep
vim.cmd([[
  if executable("ag")
    let grepprg = "ag --vimgrep"
  endif
]])

-- Run ctags on save
--vim.cmd('autocmd BufWritePost * call system("which ctags &> /dev/null && ctags -R . || exit 0")')
vim.cmd('set wildignore+=*.so,*.swp,*.zip,*.hi,*.o,*/node_modules/*,*/dist/*,*/.dist/*,*/build/*,*/.build/*,*/Godeps/*,*/elm-stuff/*,*/.gem/*,*/.git/*,*/tmp/*')

-- Set up global key bindings.
vim.cmd('let mapleader=","')
local opts = { noremap = true, silent = true }

-- Set file types
--vim.cmd('autocmd! BufNewFile,BufRead *.vs,*.fs,*.vert,*.frag set ft=glsl')

-- Misc helpers
vim.api.nvim_set_keymap('n', '<leader>f', ':set filetype=', { noremap = true })                        -- set filetype helper
vim.api.nvim_set_keymap('n', '<leader>h', '<cmd>nohl<CR>', opts)                             -- clear highlighted search items
vim.api.nvim_set_keymap('n', '<leader>n', '<cmd>set invnumber invrelativenumber<CR>', opts)  -- toggle line numbering
vim.api.nvim_set_keymap('n', '<leader><leader>', '<cmd>b#<CR>', opts)                        -- switch to last active buffer
vim.api.nvim_set_keymap('n', '<leader>tt', '<cmd>tab terminal<CR>', opts)                    -- open terminal in new tab
vim.api.nvim_set_keymap('n', '<leader>tv', '<cmd>vert terminal<CR>', opts)                   -- open terminal in vertical split
vim.api.nvim_set_keymap('n', '<leader>j', '<cmd>%!jq<CR>', opts)                             -- pretty format JSON
vim.api.nvim_set_keymap('n', '<leader>pc', '<cmd>pclose<CR>', opts)                          -- close preview window

-- Search
vim.api.nvim_set_keymap('', '<C-p>', '<cmd>Files<CR>', opts)         -- File search
vim.api.nvim_set_keymap('', '<C-\\>', '<cmd>Ag<CR>', opts)           -- Ag search
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>Buffers<CR>', opts)  -- Show buffers

-- NERDTree
vim.api.nvim_set_keymap('n', '<leader>to', '<cmd>NERDTreeFocus<CR>', opts)        -- NERDTree focus/open
vim.api.nvim_set_keymap('n', '<leader>tc', '<cmd>NERDTreeClose<CR>', opts)        -- NERDTree close 
vim.api.nvim_set_keymap('n', '<leader>tr', '<cmd>NERDTreeRefreshRoot<CR>', opts)  -- NERDTree refresh 

