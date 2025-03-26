local blink = require("blink.cmp")

blink.setup({
  keymap = {
    preset = "none",
    ["<C-p>"] = { "select_prev", "fallback" },
    ["<C-n>"] = { "select_next", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
    ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
    ["<CR>"] = { "select_and_accept", "fallback" },
    ["<Up>"] = { "scroll_documentation_up", "fallback" },
    ["<Down>"] = { "scroll_documentation_down", "fallback" },
  },
  sources = {
    default = { "lsp", "path", "ripgrep", "snippets", "lazydev" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
      ripgrep = {
        module = "blink-ripgrep",
        name = "Ripgrep",
        async = true,
      },
    },
  },
  fuzzy = { implementation = "rust" },
  signature = {
    enabled = true,
  },
  appearance = {
    -- signature background doesn't work correctly in tokyonight
    use_nvim_cmp_as_default = true,
  },
  completion = {
    ghost_text = {
      enabled = true,
    },
    menu = {
      scrollbar = false,
      draw = {
        columns = { { "label", gap = 1 }, { "kind_icon", gap = 1, "kind" } },
      },
    },
    documentation = {
      auto_show = true,
    },
  },
})
