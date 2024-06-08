require("grug-far").setup()

vim.api.nvim_set_keymap("n", "<C-f>", ":GrugFar<cr>", { silent = true })
