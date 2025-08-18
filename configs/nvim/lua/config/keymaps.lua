-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
vim.g.mapleader = " "
local keymap = vim.keymap

-- Escape
keymap.set("i", "jk", "<ESC>")
keymap.set("i", "JK", "<ESC>")
keymap.set("i", "jK", "<ESC>")
keymap.set("i", "Jk", "<ESC>")

-- Turbomove
keymap.set({ "n", "v" }, "J", "5j")
keymap.set({ "n", "v" }, "K", "5k")
keymap.set({ "n", "v" }, "L", "5l")
keymap.set({ "n", "v" }, "H", "5h")

-- Navigate between windows
keymap.set("n", "<C-J>", "<C-W><C-J>")
keymap.set("n", "<C-K>", "<C-W><C-K>")
keymap.set("n", "<C-L>", "<C-W><C-L>")
keymap.set("n", "<C-H>", "<C-W><C-H>")

-- System clipboard
keymap.set("v", "<leader>y", '"+y')
keymap.set("n", "<leader>p", '"+p')
keymap.set("n", "<C-K>", "<C-W><C-K>")
keymap.set("n", "<C-L>", "<C-W><C-L>")
keymap.set("n", "<C-H>", "<C-W><C-H>")

-- Window Management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>closbbbR>", { desc = "Close current split" }) -- close current split window

-- Tab Management
keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>to", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
keymap.set("n", "}", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "{", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab

keymap.set("n", "<leader>/", "<cmd>set hlsearch!<CR>", { desc = "Toggle search highlight" }) -- toggle search highlight
keymap.set("n", "/", "<cmd>set hlsearch<CR>/", { desc = "Toggle search highlight" }) -- toggle search highlight

-- Hotkeys
keymap.set("v", "<leader>enum", "senumerate()<esc>P?for\\s<cr>3lai, <esc>/enumerate<cr>")
keymap.set("v", "<leader>arg", "xmai()<esc>P`ai")
keymap.set("v", "<leader>next", "snext(iter(<esc>pa))<esc>")

keymap.set("n", "<leader>gb", function()
  require("gitsigns").blame_line({ full = true })
end)

keymap.set("n", "}", "<cmd>tabnext<CR>", { desc = "Next tab" })
keymap.set("n", "{", "<cmd>tabprevious<CR>", { desc = "Prev tab" })

vim.cmd(
  [[iabbr tomltool [tool.black]<CR>line-length = 120<CR><CR>[tool.isort]<CR>line_length = 120<CR>project = "anemoi"<CR>force_single_line = true]]
)
vim.cmd([[iabbr bp __import__("pdb").set_trace() #TODO delme]])
vim.cmd([[iabbr sysexit __import__("sys").exit() #TODO delme]])
vim.cmd([[iabbr imnp import numpy as np]])
vim.cmd([[iabbr implt import matplotlib.pyplot as plt]])
vim.cmd(
  [[iabbr pytargs <esc>I<cr><cr><cr>def main(args):<esc>ggOfrom argparse import ArgumentParser<esc>Go<esc>I<cr><cr>if __name__ == "__main__":<cr>parser = ArgumentParser()<cr># parser.add_argument('arg')<cr># parser.add_argument('--kwarg')<cr><cr>main(parser.parse_args())<esc>`ai<tab>]]
)

keymap.set("n", "<leader>rg", 'y:%s/<C-R>"//g<left><left>')
keymap.set("n", "<leader>rl", 'y:s/<C-R>"//g<left><left>')
