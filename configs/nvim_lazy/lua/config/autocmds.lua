-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Enable cursorline in active window
local cursorLineGroup = vim.api.nvim_create_augroup("AddCursorLine", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  pattern = "*",
  command = "setlocal cursorline",
  group = cursorLineGroup,
})

vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
  pattern = "*",
  command = "setlocal nocursorline",
  group = cursorLineGroup,
})
