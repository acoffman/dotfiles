-- Install packer
local execute = vim.api.nvim_command

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
end

vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]], false)

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'scrooloose/nerdcommenter'
  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
  use 'itchyny/lightline.vim'
  use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'} }
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'RRethy/nvim-base16'
  use 'broadinstitute/vim-wdl'
  use 'godlygeek/tabular'
  use 'tpope/vim-rails'
  use 'kosayoda/nvim-lightbulb'
  use 'kyazdani42/nvim-web-devicons'
  use 'jparise/vim-graphql'
end)

--Incremental completion
vim.o.inccommand = "nosplit"

--Highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true

--Case insensitive unless caps
vim.o.ignorecase = true
vim.o.smartcase = true

--Line numbers on
vim.wo.number = true
vim.wo.relativenumber = true

-- Keep 3 lines of context as you scroll
vim.o.scrolloff = 3

--Do not save when switching buffers
vim.o.hidden = true

-- have command-line completion first list the available options and complete the longest common part, then
-- have further <Tab>s cycle through the possibilities
vim.o.wildmode = "list:longest,full"

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn="yes"
vim.o.ttimeout = true
vim.o.ttimeoutlen = 0

--No swapfile
vim.o.swapfile = false

--Dont wrap lines
vim.o.wrap = false

--Colorscheme
vim.o.termguicolors = true
vim.cmd[[colorscheme base16-tomorrow-night]]

--Use two space tabs and don't expand
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

--Visual bell instead of beeps
vim.o.visualbell = true

-- Display extra whitespace
vim.opt.listchars = { trail = '·', tab = '»·' }


--Remap leader to ,
vim.g.mapleader = ","

--Have Y act like D and C
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true})

-- navigate splits
vim.api.nvim_set_keymap('n',  '<C-k>', ':wincmd k<CR>', { silent = true})
vim.api.nvim_set_keymap('n',  '<C-j>', ':wincmd j<CR>', { silent = true})
vim.api.nvim_set_keymap('n',  '<C-h>', ':wincmd h<CR>', { silent = true})
vim.api.nvim_set_keymap('n',  '<C-l>', ':wincmd l<CR>', { silent = true})
vim.api.nvim_set_keymap('n',  '<C-n>', ':vsplit <CR>', { silent = true})
vim.api.nvim_set_keymap('n',  '<C-s>', ':split <CR>', { silent = true})

-- Set completeopt to have a better completion experience
vim.o.completeopt="menuone,noinsert"

-- Highlight on yank
vim.api.nvim_exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]], false)

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
    generic_sorter =  require'telescope.sorters'.get_fzy_sorter,
    file_sorter =  require'telescope.sorters'.get_fzy_sorter,
    layout_strategy = 'vertical'
  }
}
-- Telescope
vim.api.nvim_set_keymap('n', '<leader>p', [[<cmd>lua require('telescope.builtin').git_files()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>a', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>b', [[<cmd>lua require('telescope.builtin').file_browser()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>r', [[<cmd>lua require('telescope.builtin').lsp_references()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>,', [[<cmd>lua require('telescope.builtin').lsp_code_actions()<cr>]], { noremap = true, silent = true})



-- LSP settings
local nvim_lsp = require('lspconfig')
local on_attach = function(_client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
 
 
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

--turn on for LSP debugging
--vim.lsp.set_log_level("debug")

-- Enable the language servers
nvim_lsp.angularls.setup{
  on_attach = on_attach,
  filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
  root_dir = nvim_lsp.util.root_pattern("angular.json")
}
nvim_lsp.tsserver.setup{
  on_attach = on_attach
}
nvim_lsp.graphql.setup{
  on_attach = on_attach
}

nvim_lsp.solargraph.setup {
  on_attach = on_attach,
  cmd = { "solargraph", "stdio" },
  filetypes = { "ruby" },
    root_dir = nvim_lsp.util.root_pattern("Gemfile"),
    settings = {
      solargraph = {
        --rubocop
        diagnostics = true
    }
  }
}

-- Map :Format to vim.lsp.buf.formatting()
vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])


-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- Show lightbulb when code action is available
vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
