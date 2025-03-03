return {
  -- colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "moon",
        plugins = {
          auto = true,
        },
      })
      vim.cmd("colorscheme tokyonight")
    end,
  },

  -- general ui improvements
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "AndreM222/copilot-lualine",
    },
    event = "VeryLazy",
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
      require("config.oil")
    end,
  },

  -- lsp
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "kosayoda/nvim-lightbulb",
      "saghen/blink.cmp",
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
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000,
    config = function()
      require("config.diagnostic")
    end,
  },

  {
    "j-hui/fidget.nvim",
    config = true,
    event = { "BufReadPost", "BufNewFile" },
  },

  -- completion
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      "fang2hou/blink-copilot",
      "rafamadriz/friendly-snippets",
      "mikavilpas/blink-ripgrep.nvim",
    },
    config = function()
      require("config.blink")
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

  -- clipboard manager
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("config.neoclip")
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

  -- surround
  {
    "kylechui/nvim-surround",
    config = true,
    event = "VeryLazy",
  },

  -- neovim support in lua lsp
  {
    "folke/lazydev.nvim",
    ft = "lua",
    config = true,
  },

  -- global find and replace panel
  {
    "magicduck/grug-far.nvim",
    config = function()
      require("config.grug-far")
    end,
    event = "VeryLazy",
  },
  -- language specific % support
  {
    "andymass/vim-matchup",
  },
  -- proportional scrolloff
  {
    "tonymajestro/smart-scrolloff.nvim",
    opts = {
      scrolloff_percentage = 0.2,
    },
  },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("config.copilot")
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
  },
}
