--Incremental completion
vim.o.inccommand = "nosplit"

--Highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true

--Case insensitive unless caps
vim.o.ignorecase = true
vim.o.smartcase = true

--Line numbers on
vim.wo.number = true
vim.wo.relativenumber = true

-- Keep 3 lines of context as you scroll
vim.o.scrolloff = 3

--Do not save when switching buffers
vim.o.hidden = true

-- have command-line completion first list the available options and complete the longest common part, then
-- have further <Tab>s cycle through the possibilities
vim.o.wildmode = "list:longest,full"

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noinsert"

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"
vim.o.ttimeout = true
vim.o.ttimeoutlen = 0

--No swapfile
vim.o.swapfile = false

--Dont wrap lines
vim.o.wrap = false

--Colorscheme
vim.o.termguicolors = true

--Use two space tabs and don't expand
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

--Visual bell instead of beeps
vim.o.visualbell = true

-- Display extra whitespace
vim.opt.list = true
vim.opt.listchars:append({ trail = "•", tab = "»·" })

-- Unified statusline
vim.o.laststatus = 3

vim.opt.shortmess:append({ I = true })
