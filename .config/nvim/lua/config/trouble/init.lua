vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").open("document_diagnostics") end)

-- <c-t> opens telescope results in trouble
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

local telescope = require("telescope")

telescope.setup {
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
}

-- x will remove items from the Telescope results list: https://github.com/folke/trouble.nvim/issues/149
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "Trouble",
  callback = function(event)
    if require("trouble.config").options.mode ~= "telescope" then
      return
    end

    local function delete()
      local folds = require("trouble.folds")
      local telescope = require("trouble.providers.telescope")

      local ord = { "" } -- { filename, ... }
      local files = { [""] = { 1, 1, 0 } } -- { [filename] = { start, end, start_index } }
      for i, result in ipairs(telescope.results) do
        if files[result.filename] == nil then
          local next = files[ord[#ord]][2] + 1
          files[result.filename] = { next, next, i }
          table.insert(ord, result.filename)
        end
        if not folds.is_folded(result.filename) then
          files[result.filename][2] = files[result.filename][2] + 1
        end
      end

      local line = unpack(vim.api.nvim_win_get_cursor(0))
      for i, id in ipairs(ord) do
        if line == files[id][1] then -- Group
          local next = ord[i + 1]
          for _ = files[id][3], next and files[next][3] - 1 or #telescope.results do
            table.remove(telescope.results, files[id][3])
          end
          break
        elseif line <= files[id][2] then -- Item
          table.remove(telescope.results, files[id][3] + (line - files[id][1]) - 1)
          break
        end
      end

      if #telescope.results == 0 then
        require("trouble").close()
      else
        require("trouble").refresh { provider = "telescope", auto = false }
      end
    end

    vim.keymap.set("n", "x", delete, { buffer = event.buf })
  end,
})
