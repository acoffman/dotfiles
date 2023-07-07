--turn on for LSP debugging
--vim.lsp.set_log_level("debug")

-- LSP settings
local nvim_lsp = require('lspconfig')

local on_attach = function(_client, bufnr)
  require("lsp_signature").on_attach()

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
 
 
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

-- Enable the language servers
local capabilities = require('cmp_nvim_lsp').default_capabilities()

nvim_lsp.angularls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
  root_dir = nvim_lsp.util.root_pattern("angular.json")
}

nvim_lsp.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

nvim_lsp.graphql.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

nvim_lsp.solargraph.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "solargraph", "stdio" },
  filetypes = { "ruby" },
    root_dir = nvim_lsp.util.root_pattern("Gemfile"),
    settings = {
      solargraph = {
        --rubocop
        diagnostics = false
    }
  }
}

-- setup nvim lightbulb
require('nvim-lightbulb').setup({autocmd = {enabled = true}})
