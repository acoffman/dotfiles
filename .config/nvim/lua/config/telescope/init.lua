-- Telescope
require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
    generic_sorter = require("telescope.sorters").get_fzy_sorter,
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    layout_strategy = "vertical",
    prompt_prefix = "  ",
  },
})

require("telescope").load_extension("fzf")

vim.api.nvim_set_keymap(
  "n",
  "<leader>p",
  [[<cmd>lua require('telescope.builtin').git_files({show_untracked = true})<cr>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>a",
  [[<cmd>lua require('telescope.builtin').live_grep()<cr>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>r",
  [[<cmd>lua require('telescope.builtin').lsp_references()<cr>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>b",
  [[<cmd>lua require('telescope.builtin').buffers()<cr>]],
  { noremap = true, silent = true }
)
