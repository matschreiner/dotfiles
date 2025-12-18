vim.g.mapleader = " "
local keymap = vim.keymap

-- Escape
keymap.set("i", "jk", "<ESC>")
keymap.set("i", "JK", "<ESC>")
keymap.set("i", "jK", "<ESC>")
keymap.set("i", "Jk", "<ESC>")
keymap.set("i", "kj", "<ESC>")
keymap.set("i", "KJ", "<ESC>")
keymap.set("i", "Kj", "<ESC>")
keymap.set("i", "kJ", "<ESC>")

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

-- Navigate from terminal mode
keymap.set("t", "<C-J>", "<C-\\><C-N><C-W><C-J>")
keymap.set("t", "<C-K>", "<C-\\><C-N><C-W><C-K>")
keymap.set("t", "<C-L>", "<C-\\><C-N><C-W><C-L>")
keymap.set("t", "<C-H>", "<C-\\><C-N><C-W><C-H>")

-- System clipboard
keymap.set("v", "<leader>y", '"+y')
keymap.set("n", "<leader>p", '"+p')

-- Window Management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>closbbbR>", { desc = "Close current split" }) -- close current split window

-- Smart splits - Window resizing (repeatable mode)
local function resize_and_continue(direction)
    return function()
        if direction == "h" then
            require("smart-splits").resize_left()
        elseif direction == "j" then
            require("smart-splits").resize_down()
        elseif direction == "k" then
            require("smart-splits").resize_up()
        elseif direction == "l" then
            require("smart-splits").resize_right()
        end

        -- Set up temporary keymaps for repeating
        local opts = { buffer = true, silent = true, nowait = true }
        vim.keymap.set("n", "h", resize_and_continue("h"), opts)
        vim.keymap.set("n", "j", resize_and_continue("j"), opts)
        vim.keymap.set("n", "k", resize_and_continue("k"), opts)
        vim.keymap.set("n", "l", resize_and_continue("l"), opts)

        -- Press ESC to exit resize mode
        vim.keymap.set("n", "<ESC>", function()
            vim.keymap.del("n", "h", { buffer = true })
            vim.keymap.del("n", "j", { buffer = true })
            vim.keymap.del("n", "k", { buffer = true })
            vim.keymap.del("n", "l", { buffer = true })
            vim.keymap.del("n", "<ESC>", { buffer = true })
        end, opts)
    end
end

keymap.set("n", "<C-w>h", resize_and_continue("h"), { desc = "Resize left (repeatable)" })
keymap.set("n", "<C-w>j", resize_and_continue("j"), { desc = "Resize down (repeatable)" })
keymap.set("n", "<C-w>k", resize_and_continue("k"), { desc = "Resize up (repeatable)" })
keymap.set("n", "<C-w>l", resize_and_continue("l"), { desc = "Resize right (repeatable)" })

-- Tab Management

keymap.set("n", "tn", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "tq", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "to", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
keymap.set("n", "tl", "<cmd>tabnext<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "th", "<cmd>tabprevious<CR>", { desc = "Go to previous tab" }) --  go to previous tab

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
vim.cmd([[
iabbr defmain import argparse<CR><CR><CR>def main(args):<CR>pass<CR><CR><CR>if __name__ == "__main__":<CR>argparser = argparse.ArgumentParser()<CR># argparser.add_argument('arg', arg)<CR># argparser.add_argument('--kwarg', kwarg)<CR>args = argparser.parse_args()<CR>main(args)
]])

keymap.set("n", "<leader>rg", 'y:%s/<C-R>"//g<left><left>')
keymap.set("n", "<leader>rl", 'y:s/<C-R>"//g<left><left>')

keymap.set("n", "<leader>ti", "A  # type: ignore<ESC>")
