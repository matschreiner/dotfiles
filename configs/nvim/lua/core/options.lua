vim.opt.relativenumber = false
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.splitright = true

-- Folding configuration (Treesitter-based)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = true -- Enable folding
vim.opt.foldlevel = 99 -- Start with all folds open (high value = open)
vim.opt.foldlevelstart = 99 -- Always start with folds open
vim.opt.foldcolumn = "0" -- Don't show fold column
vim.opt.foldnestmax = 10 -- Maximum fold nesting
