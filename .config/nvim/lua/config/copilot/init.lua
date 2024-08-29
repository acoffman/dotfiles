local copilot = require("copilot")

copilot.setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})

local chat = require("CopilotChat")
local select = require("CopilotChat.select")

chat.setup({
  mappings = {
    reset = {
      normal = "<C-x>",
      insert = "<C-x>",
    },
  },
})

local function copilot_ask(selection_type)
  vim.ui.input({ prompt = "Copilot: " }, function(input)
    if input ~= nil and input ~= "" then
      chat.ask(input, { selection = selection_type })
    end
  end)
end

vim.keymap.set("n", "<leader>cc", function()
  copilot_ask(select.buffer)
end)

vim.keymap.set("v", "<leader>cc", function()
  copilot_ask(select.visual)
end)
