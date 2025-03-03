-- cmp setup (no longer utilized. left for reference)
-- previous lazy config:
--
-- {
--   "hrsh7th/nvim-cmp",
--   dependencies = {
--     "hrsh7th/cmp-nvim-lsp",
--     "hrsh7th/cmp-buffer",
--     "hrsh7th/cmp-path",
--     "hrsh7th/cmp-cmdline",
--     "onsails/lspkind.nvim",
--     "ray-x/lsp_signature.nvim",
--     "ray-x/cmp-treesitter",
--   },
--   config = function()
--     require("config.cmp")
--   end,
--   event = "InsertEnter",
-- },

local cmp = require("cmp")
local lspkind = require("lspkind")
local icons = require("config.shared").icons

cmp.setup({
  mapping = {
    ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
    ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    -- Add tab support
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-s>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-Space>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },
  formatting = {
    fields = { "abbr", "kind", "menu" },
    expandable_indicator = true,
    format = lspkind.cmp_format({
      maxwidth = 50,
      mode = "symbol_text",
      menu = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        treesitter = "[TS]",
      },
      symbol_map = { Treesitter = icons.ui.treesitter },
      before = function(entry, vim_item)
        if entry.source.name == "treesitter" then
          vim_item.kind = "Treesitter"
        end
        return vim_item
      end,
    }),
  },
  sources = {
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "treesitter" },
    { name = "buffer", keyword_length = 4 },
    { name = "lazydev" },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  matching = {
    disallow_fuzzy_matching = false,
    disallow_fullfuzzy_matching = false,
    disallow_partial_matching = false,
    disallow_partial_fuzzy_matching = false,
    disallow_prefix_unmatching = false,
    disallow_symbol_nonprefix_matching = false,
  },
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "treesitter" },
    { name = "buffer" },
  },
})
