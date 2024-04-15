require("oil").setup({
  view_options = {
    show_hidden = true,
  },
})
-- replace :Explore with Oil
vim.api.nvim_create_user_command("Explore", function(opts)
  vim.cmd("Oil " .. opts.args)
end, { nargs = "?" })
