local icons = require("config.shared").icons

require("lualine").setup({
  options = {
    theme = "tokyonight",
    globalstatus = true,
    component_separators = "|",
    section_separators = { left = "", right = "" },
  },
  -- use same icons as trouble.nvim
  sections = {
    lualine_b = {
      "branch",
      "diff",
      {
        "diagnostics",
        symbols = {
          error = icons.diagnostics.error,
          warn = icons.diagnostics.warn,
          hint = icons.diagnostics.hint,
          info = icons.diagnostics.info,
          other = icons.diagnostics.other,
        },
      },
    },
  },
})
