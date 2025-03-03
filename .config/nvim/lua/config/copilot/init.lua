local copilot = require("copilot")
local icons = require("config.shared").icons
local chat = require("CopilotChat")
local select = require("CopilotChat.select")

copilot.setup({
  suggestion = {
    enabled = true,
    auto_trigger = false,
  },
  panel = { enabled = false },
})

chat.setup({
  mappings = {
    reset = {
      normal = "<C-x>",
      insert = "<C-x>",
    },
  },
  question_header = icons.ui.user .. "  ",
  answer_header = icons.ui.bot .. "  ",
  error_header = icons.diagnostics.warn .. "  ",
  context = { "buffers:all", "quickfix" },
  select = select.visual,
})

local function copilot_ask(selection_type, sticky_prompt)
  vim.ui.input({ prompt = "Copilot: " }, function(input)
    if input ~= nil and input ~= "" then
      if sticky_prompt ~= nil and sticky_prompt ~= "" then
        input = sticky_prompt .. "\n\n" .. input
      end
      chat.ask(input, { selection = selection_type })
    end
  end)
end

vim.keymap.set("n", "<leader>ct", chat.toggle)

vim.keymap.set("n", "<leader>cg", function()
  copilot_ask(select.buffer, "> /COPILOT_GENERATE")
end)
vim.keymap.set("v", "<leader>cg", function()
  copilot_ask(select.visual, "> /COPILOT_GENERATE")
end)

vim.keymap.set("n", "<leader>cc", function()
  copilot_ask(select.buffer)
end)

vim.keymap.set("v", "<leader>cc", function()
  copilot_ask(select.visual)
end)

vim.keymap.set({ "v", "n" }, "<leader>cp", function()
  chat.select_prompt()
end)
