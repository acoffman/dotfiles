local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    javascript = { "prettierd" },
    html = { "prettierd" },
    typescript = { "prettierd" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = false
  }
})
