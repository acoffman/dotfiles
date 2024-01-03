--Have Y act like D and C
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })

-- navigate splits
vim.api.nvim_set_keymap("n", "<C-k>", ":wincmd k<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", ":wincmd j<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-h>", ":wincmd h<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", ":wincmd l<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-n>", ":vsplit <CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-s>", ":split <CR>", { silent = true })
