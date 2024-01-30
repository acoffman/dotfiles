require("nvim-treesitter.configs").setup({
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
    "markdown_inline",
    "vimdoc",
    "angular",
  },
  highlight = {
    enable = true, -- false will disable the whole extension
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
})
