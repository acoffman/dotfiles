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
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = false,
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
