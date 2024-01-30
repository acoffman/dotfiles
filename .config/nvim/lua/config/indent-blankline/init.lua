local indent = require("ibl")

indent.setup({
  indent = {
    char = "│",
    tab_char = "│",
  },
  scope = {
    enabled = false,
  },
  exclude = {
    filetypes = {
      "help",
      "Trouble",
      "trouble",
      "lazy",
      "mason",
    },
  },
})
