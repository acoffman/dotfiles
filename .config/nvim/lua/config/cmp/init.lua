-- cmp setup
local cmp = require'cmp'
local lspkind = require('lspkind')
cmp.setup({
	  mapping = {
	    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
	    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
	    ['<C-p>'] = cmp.mapping.select_prev_item(),
	    ['<C-n>'] = cmp.mapping.select_next_item(),
	    -- Add tab support
	    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
	    ['<Tab>'] = cmp.mapping.select_next_item(),
	    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
	    ['<C-f>'] = cmp.mapping.scroll_docs(4),
	    ['<C-s>'] = cmp.mapping.complete(),
	    ['<C-e>'] = cmp.mapping.close(),
	    ['<C-Space>'] = cmp.mapping.confirm({
	      behavior = cmp.ConfirmBehavior.Insert,
	      select = true,
	    }),
	    ['<CR>'] = cmp.mapping.confirm({
	      behavior = cmp.ConfirmBehavior.Insert,
	      select = true,
	    }),
	  },
	  formatting = {
	    format = lspkind.cmp_format({
	      maxwidth = 50,
	      mode = 'symbol_text',
        menu = ({
	        buffer = "[Buffer]",
	        nvim_lsp = "[LSP]",
	      })
	    })
	  },
    sources = {
	    { name = 'nvim_lsp_signature_help' },
	    { name = 'nvim_lsp' },
	    { name = 'path' },
	    { name = 'buffer', keyword_length = 5 },
	  },
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
