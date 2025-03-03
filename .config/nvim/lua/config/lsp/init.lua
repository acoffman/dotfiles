--turn on for LSP debugging
--vim.lsp.set_log_level("debug")

require("mason").setup()
require("mason-lspconfig").setup({
  automatic_installation = true,
  ensure_installed = {
    "solargraph",
    "ts_ls",
    "angularls",
    "graphql",
    "lua_ls",
    "jdtls",
    "pylsp",
    "ruby_lsp",
    "ruff",
  },
})

-- LSP settings
local nvim_lsp = require("lspconfig")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local bufnr = ev.buf
    local opts = { noremap = true, silent = true, buffer = bufnr }

    vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
  end,
})

-- Enable the language servers
local capabilities = require("blink.cmp").get_lsp_capabilities()

nvim_lsp.angularls.setup({
  capabilities = capabilities,
  filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "angular" },
  root_dir = nvim_lsp.util.root_pattern("angular.json"),
})

nvim_lsp.ts_ls.setup({
  capabilities = capabilities,
})

nvim_lsp.graphql.setup({
  capabilities = capabilities,
})

nvim_lsp.sourcekit.setup({
  capabilities = capabilities,
})

nvim_lsp.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
    },
  },
})

nvim_lsp.solargraph.setup({
  capabilities = capabilities,
  cmd = { "bundle", "exec", "solargraph", "stdio" },
  filetypes = { "ruby" },
  --root_dir = nvim_lsp.util.root_pattern("Gemfile"),
  settings = {
    solargraph = {
      --rubocop
      diagnostics = false,
    },
  },
})

nvim_lsp.ruby_lsp.setup({
  capabilities = capabilities,
})

nvim_lsp.pylsp.setup({
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = false },
        pyflakes = { enabled = false },
        yapf = { enabled = false },
        flake8 = { enabled = false },
        mccabe = { enabled = false },
      },
    },
  },
})

-- setup nvim lightbulb
require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
