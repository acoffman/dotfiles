-- disable built in virtual text diagnostics
vim.diagnostic.config({ virtual_text = false })

-- pull background color from theme
local colors = require("tokyonight.colors").setup()

require('tiny-inline-diagnostic').setup({
  preset = "simple",
  hi = {
    background = colors.bg
  },
  options = {
    use_icons_from_diagnostic = true
  }
})

