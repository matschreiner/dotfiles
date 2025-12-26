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

-- Restore original J (join lines) to <leader>j
keymap.set("n", "<leader>j", "J", { desc = "Join lines" })

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
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Window swapping from terminal mode (set up early, actual keymaps defined later)
keymap.set("t", "<C-w>H", "<C-\\><C-n><C-w>H", { desc = "Swap window left from terminal" })
keymap.set("t", "<C-w>J", "<C-\\><C-n><C-w>J", { desc = "Swap window down from terminal" })
keymap.set("t", "<C-w>K", "<C-\\><C-n><C-w>K", { desc = "Swap window up from terminal" })
keymap.set("t", "<C-w>L", "<C-\\><C-n><C-w>L", { desc = "Swap window right from terminal" })

-- Smart splits - Window resizing and swapping (repeatable mode)
-- Forward declarations to fix call order
local resize_and_continue, swap_and_continue

-- Common function to set up all temporary keymaps
local function setup_window_mode_keymaps()
    local opts = { buffer = true, silent = true, nowait = true }

    -- Resize keymaps (lowercase)
    vim.keymap.set("n", "h", resize_and_continue("h"), opts)
    vim.keymap.set("n", "j", resize_and_continue("j"), opts)
    vim.keymap.set("n", "k", resize_and_continue("k"), opts)
    vim.keymap.set("n", "l", resize_and_continue("l"), opts)

    -- Swap keymaps (uppercase)
    vim.keymap.set("n", "H", swap_and_continue("h"), opts)
    vim.keymap.set("n", "J", swap_and_continue("j"), opts)
    vim.keymap.set("n", "K", swap_and_continue("k"), opts)
    vim.keymap.set("n", "L", swap_and_continue("l"), opts)

    -- ESC to exit resize/swap mode (works in both normal and terminal mode)
    local function exit_window_mode()
        pcall(vim.keymap.del, "n", "h", { buffer = true })
        pcall(vim.keymap.del, "n", "j", { buffer = true })
        pcall(vim.keymap.del, "n", "k", { buffer = true })
        pcall(vim.keymap.del, "n", "l", { buffer = true })
        pcall(vim.keymap.del, "n", "H", { buffer = true })
        pcall(vim.keymap.del, "n", "J", { buffer = true })
        pcall(vim.keymap.del, "n", "K", { buffer = true })
        pcall(vim.keymap.del, "n", "L", { buffer = true })
        pcall(vim.keymap.del, "n", "<ESC>", { buffer = true })
        pcall(vim.keymap.del, "t", "<ESC>", { buffer = true })
    end

    vim.keymap.set("n", "<ESC>", exit_window_mode, opts)
    vim.keymap.set("t", "<ESC>", function()
        vim.cmd("stopinsert") -- Exit terminal mode
        exit_window_mode()
    end, opts)
end

resize_and_continue = function(direction)
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

        vim.cmd("redraw") -- Clear any command echoes
        setup_window_mode_keymaps()
    end
end

swap_and_continue = function(direction)
    return function()
        if direction == "h" then
            require("smart-splits").swap_buf_left()
        elseif direction == "j" then
            require("smart-splits").swap_buf_down()
        elseif direction == "k" then
            require("smart-splits").swap_buf_up()
        elseif direction == "l" then
            require("smart-splits").swap_buf_right()
        end

        vim.cmd("redraw") -- Clear any command echoes
        setup_window_mode_keymaps()
    end
end

keymap.set("n", "<C-w>h", resize_and_continue("h"), { desc = "Resize left (repeatable)" })
keymap.set("n", "<C-w>j", resize_and_continue("j"), { desc = "Resize down (repeatable)" })
keymap.set("n", "<C-w>k", resize_and_continue("k"), { desc = "Resize up (repeatable)" })
keymap.set("n", "<C-w>l", resize_and_continue("l"), { desc = "Resize right (repeatable)" })

-- Window swapping with capital letters (C-w H/J/K/L) - stays in window mode
keymap.set("n", "<C-w>H", swap_and_continue("h"), { desc = "Swap window left (repeatable)" })
keymap.set("n", "<C-w>J", swap_and_continue("j"), { desc = "Swap window down (repeatable)" })
keymap.set("n", "<C-w>K", swap_and_continue("k"), { desc = "Swap window up (repeatable)" })
keymap.set("n", "<C-w>L", swap_and_continue("l"), { desc = "Swap window right (repeatable)" })

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

-- Folding
keymap.set("n", "zz", "za", { desc = "Toggle fold" }) -- toggle fold (replaces center screen)
keymap.set("n", "zo", "zR", { desc = "Open all folds" })
keymap.set("n", "zc", "zM", { desc = "Close all folds" })

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
