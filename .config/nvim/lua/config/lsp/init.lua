--turn on for LSP debugging
--vim.lsp.set_log_level("debug")

require("mason").setup()
require("mason-lspconfig").setup({
  automatic_installation = true,
  ensure_installed = { "solargraph", "tsserver", "angularls", "graphql", "lua_ls", "jdtls", "pylsp" },
})

-- neodev must be set up before LSP per the readme
require("neodev").setup({})

local icons = require("config.shared").icons

-- LSP settings
local nvim_lsp = require("lspconfig")

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.error,
      [vim.diagnostic.severity.WARN] = icons.diagnostics.warn,
      [vim.diagnostic.severity.HINT] = icons.diagnostics.hint,
      [vim.diagnostic.severity.INFO] = icons.diagnostics.info,
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- dont show the inline hint in addition to the floating window
    require("lsp_signature").on_attach({
      hint_enable = false,
      max_height = 35,
      max_width = 100,
    })

    local bufnr = ev.buf
    local opts = { silent = true }

    vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

    --  on hover, show diagnostics in floating window, disable inline diagnostics
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function()
        local hold_opts = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = "rounded",
          source = "if_many",
          prefix = "",
          scope = "line",
          header = "",
        }
        local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
        if next(vim.diagnostic.get(bufnr, { lnum = row - 1 })) == nil then
          vim.diagnostic.show()
        else
          vim.diagnostic.hide()
          vim.diagnostic.open_float(nil, hold_opts)
        end
      end,
    })
  end,
})

-- Enable the language servers
local capabilities = require("cmp_nvim_lsp").default_capabilities()

nvim_lsp.angularls.setup({
  capabilities = capabilities,
  filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "angular" },
  root_dir = nvim_lsp.util.root_pattern("angular.json"),
})

nvim_lsp.tsserver.setup({
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
  cmd = { "solargraph", "stdio" },
  filetypes = { "ruby" },
  root_dir = nvim_lsp.util.root_pattern("Gemfile"),
  settings = {
    solargraph = {
      --rubocop
      diagnostics = false,
    },
  },
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
