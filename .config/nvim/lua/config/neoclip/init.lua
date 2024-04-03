-- From tips section of README
local function is_whitespace(line)
  return vim.fn.match(line, [[^\s*$]]) ~= -1
end

local function all(tbl, check)
  for _, entry in ipairs(tbl) do
    if not check(entry) then
      return false
    end
  end
  return true
end

-- override default neoclip prompt in telescope, doesn't seem to be configurable the normal way
local picker_utils = require("neoclip.picker_utils")
---@diagnostic disable-next-line: duplicate-set-field
picker_utils.make_prompt_title = function(_)
  return "Yank History"
end

require("neoclip").setup({
  history = 500,
  enable_persistent_history = false,
  filter = function(data)
    return not all(data.event.regcontents, is_whitespace)
  end,
  keys = {
    telescope = {
      i = {
        paste = "<cr>",
      },
      n = {
        paste = "<cr>",
      },
    },
  },
})

vim.keymap.set("n", "<leader>cb", function()
  require("telescope").extensions.neoclip.default()
end, { noremap = true, silent = true })
