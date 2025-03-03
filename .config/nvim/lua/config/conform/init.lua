local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    javascript = { "prettierd" },
    html = { "prettierd" },
    angular = { "prettier" },
    typescript = { "prettierd" },
    lua = { "stylua" },
    typescriptreact = { "prettier" },
    python = { "ruff_fix", "ruff_format" },
    swift = { "swift_format" },
    ruby = { "rubocop" },
  },
  format_on_save = {
    timeout_ms = 1000,
    lsp_format = "never",
  },
  formatters = {
    prettier = {
      options = {
        ft_parsers = {
          angular = "angular",
        },
      },
    },
  },
})
