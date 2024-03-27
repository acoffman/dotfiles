return {
  -- colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd("colorscheme tokyonight")
    end,
  },

  -- general ui improvements
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("config.lualine")
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("config.indent-blankline")
    end,
  },

  {
    "stevearc/dressing.nvim",
    lazy = false,
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
  },

  -- like netrw, but you can edit the filesystem
  {
    "stevearc/oil.nvim",
    lazy = false,
    config = function()
      require("oil").setup({
        view_options = {
          show_hidden = true,
        },
      })
      -- replace :Explore with Oil
      vim.api.nvim_create_user_command("Explore", function(opts)
        vim.cmd("Oil " .. opts.args)
      end, { nargs = "?" })
    end,
  },

  -- lsp
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "kosayoda/nvim-lightbulb",
    },
    config = function()
      require("config.lsp")
    end,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
  },

  {
    "mfussenegger/nvim-jdtls",
  },

  {
    "j-hui/fidget.nvim",
    config = true,
    event = { "BufReadPost", "BufNewFile" },
  },

  -- completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind.nvim",
      "ray-x/lsp_signature.nvim",
      "ray-x/cmp-treesitter",
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
      },
    },
    config = function()
      require("config.cmp")
    end,
    event = "InsertEnter",
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end,
    event = "BufReadPost",
  },

  -- git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("config.git")
    end,
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
      require("config.telescope")
    end,
  },

  -- trouble
  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("config.trouble")
    end,
    event = "VeryLazy",
  },

  -- formatters
  {
    "stevearc/conform.nvim",
    config = function()
      require("config.conform")
    end,
    event = "BufWritePre",
    cmd = "ConformInfo",
  },

  -- move visual selections
  {
    "echasnovski/mini.move",
    config = function()
      require("config.move")
    end,
  },

  -- breadcrumbs
  "Bekaboo/dropbar.nvim",

  -- commenting
  "scrooloose/nerdcommenter",

  -- syntax
  {
    "broadinstitute/vim-wdl",
    ft = "wdl",
  },
  {
    "jparise/vim-graphql",
    ft = { "gql", "graphql" },
  },
  {
    "habamax/vim-rst",
    ft = "rst",
  },
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby" },
  },

  -- highlight matching tokens
  {
    "RRethy/vim-illuminate",
    event = "BufNew",
  },

  -- surround
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end,
    event = "VeryLazy",
  },

  -- neovim support in lua lsp
  {
    "folke/neodev.nvim",
  },
}
