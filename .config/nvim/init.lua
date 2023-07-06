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
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
  use 'lewis6991/gitsigns.nvim'
  use 'neovim/nvim-lspconfig'
  use 'RRethy/nvim-base16'
  use 'broadinstitute/vim-wdl'
  use 'godlygeek/tabular'
  use 'tpope/vim-rails'
  use { 'kosayoda/nvim-lightbulb', requires = 'antoinemadec/FixCursorHold.nvim' }
  use 'kyazdani42/nvim-web-devicons'
  use 'jparise/vim-graphql'
  use 'habamax/vim-rst'
  use { "ray-x/lsp_signature.nvim" }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
  use 'RRethy/nvim-treesitter-endwise'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'stevearc/dressing.nvim'
  use 'stevearc/oil.nvim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'onsails/lspkind.nvim'
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

-- Unified statusline
vim.o.laststatus = 3

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
vim.api.nvim_set_keymap('n', '<leader>r', [[<cmd>lua require('telescope.builtin').lsp_references()<cr>]], { noremap = true, silent = true})



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


-- cmp setup
local cmp = require'cmp'
local lspkind = require('lspkind')
cmp.setup({
	  mapping = {
	    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
	    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
	    ['<C-p>'] = cmp.mapping.select_prev_item(),
	    ['<C-n>'] = cmp.mapping.select_next_item(),
	    -- Add tab support
	    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
	    ['<Tab>'] = cmp.mapping.select_next_item(),
	    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
	    ['<C-f>'] = cmp.mapping.scroll_docs(4),
	    ['<C-s>'] = cmp.mapping.complete(),
	    ['<C-e>'] = cmp.mapping.close(),
	    ['<C-Space>'] = cmp.mapping.confirm({
	      behavior = cmp.ConfirmBehavior.Insert,
	      select = true,
	    }),
	    ['<CR>'] = cmp.mapping.confirm({
	      behavior = cmp.ConfirmBehavior.Insert,
	      select = true,
	    }),
	  },
	  formatting = {
	    format = lspkind.cmp_format({
	      maxwidth = 50,
	      mode = 'symbol_text',
        menu = ({
	        buffer = "[Buffer]",
	        nvim_lsp = "[LSP]",
	      })
	    })
	  },
    sources = {
	    { name = 'nvim_lsp_signature_help' },
	    { name = 'nvim_lsp' },
	    { name = 'path' },
	    { name = 'buffer', keyword_length = 5 },
	  },
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Enable the language servers
local capabilities = require('cmp_nvim_lsp').default_capabilities()

nvim_lsp.angularls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
  root_dir = nvim_lsp.util.root_pattern("angular.json")
}

nvim_lsp.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

nvim_lsp.graphql.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

nvim_lsp.solargraph.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "solargraph", "stdio" },
  filetypes = { "ruby" },
    root_dir = nvim_lsp.util.root_pattern("Gemfile"),
    settings = {
      solargraph = {
        --rubocop
        diagnostics = false
    }
  }
}


require('lualine').setup()

-- setup nvim lightbulb
require('nvim-lightbulb').setup({autocmd = {enabled = true}})


-- gitsigns plugin
require('gitsigns').setup {

  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Actions
    map('n', '<leader>gp', gs.preview_hunk)
    map('n', '<leader>gb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>gd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)

  end
}

require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "c",
    "cpp",
    "go",
    "lua",
    "rust",
    "javascript",
    "typescript",
    "python",
    "ruby",
    "html",
    "css",
    "racket",
    "sql",
    "bash",
    "make",
    "comment",
    "yaml",
    "json",
    "toml",
    "regex",
    "vim",
    "markdown",
    "markdown_inline"
  },
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
  textobjects = {
    enable = true,
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["ip"] = "@parameter.inner",
      },
    },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  endwise = {
    enable = true,
  },
}

require("oil").setup({
  view_options = {
    show_hidden = true
  }
})

-- Disable netrw in favor of oil.nvim
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- replace :Explore with Oil
vim.api.nvim_create_user_command(
  'Explore',
  function(opts) 
    vim.cmd('Oil ' .. opts.args)
  end,
  { nargs = '?' }
)

require "lsp_signature".setup()
