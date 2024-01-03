local move = require("mini.move")

move.setup({
  mappings = {
    -- Visual Mode
    left = "<M-h>",
    right = "<M-l>",
    down = "<M-j>",
    up = "<M-k>",

    -- Disable Normal mode bindings
    line_left = "",
    line_right = "",
    line_down = "",
    line_up = "",
  },

  options = {
    reindent_linewise = true,
  },
})
