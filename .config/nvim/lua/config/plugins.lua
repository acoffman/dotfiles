return {
  -- colorscheme
  --{
    --'RRethy/nvim-base16',
    --lazy = false, -- Make its loaded during startup
    --priority = 1000, -- Make sure its loaded before everything else
    --config = function ()
      --vim.cmd "colorscheme base16-tomorrow-night"
    --end
  --},

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function ()
      vim.cmd "colorscheme catppuccin-mocha"
    end
  },

  -- general ui improvements
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require('lualine').setup {
        options = {
          theme = "catppuccin"
        }
      }
    end
  },

  { 
    'stevearc/dressing.nvim',
    lazy=false
  },

  {
    'stevearc/oil.nvim',
    lazy=false,
    config = function()
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
    end
  },


  -- lsp
  { 
    'neovim/nvim-lspconfig',
    dependencies = {
      'kosayoda/nvim-lightbulb'
    },
    config = function()
      require 'config.lsp'
    end,
    event = 'BufReadPost',
  },

  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    config = function()
      require('fidget').setup()
    end
  },

  -- completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'onsails/lspkind.nvim',
      'ray-x/lsp_signature.nvim'
    },
    config = function()
      require 'config.cmp'
    end,
    event = 'InsertEnter'
  },


  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'RRethy/nvim-treesitter-endwise',
      'nvim-treesitter/nvim-treesitter-textobjects'
    },
    build = ':TSUpdate',
    config = function()
      require 'config.treesitter'
    end,
    event = 'BufReadPost',
  },


  -- git
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require 'config.git'
    end
  },


  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require 'config.telescope'
    end
  },

  -- breadcrumbs
  'Bekaboo/dropbar.nvim',

  -- commenting
  'scrooloose/nerdcommenter',

  -- syntax
  'broadinstitute/vim-wdl',
  'jparise/vim-graphql',
  'habamax/vim-rst',
  'tpope/vim-rails',

  -- highlight matching tokens
  'RRethy/vim-illuminate'
}
