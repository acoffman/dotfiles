require("lualine").setup({
  options = {
    theme = "tokyonight",
  },
  -- use same icons as trouble.nvim
  sections = {
    lualine_b = {
      "branch",
      "diff",
      {
        "diagnostics",
        symbols = {
          error = " ",
          warn = " ",
          hint = " ",
          info = " ",
          other = " ",
        },
      },
    },
  },
})
