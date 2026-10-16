vim.g.mapleader = " "
local keymap = vim.keymap

-- Escape
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })
keymap.set("i", "JK", "<ESC>", { desc = "Exit insert mode" })
keymap.set("i", "jK", "<ESC>", { desc = "Exit insert mode" })
keymap.set("i", "Jk", "<ESC>", { desc = "Exit insert mode" })
keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode" })
keymap.set("i", "KJ", "<ESC>", { desc = "Exit insert mode" })
keymap.set("i", "Kj", "<ESC>", { desc = "Exit insert mode" })
keymap.set("i", "kJ", "<ESC>", { desc = "Exit insert mode" })

-- Turbomove
keymap.set({ "n", "v" }, "J", "5j", { desc = "Move down 5 lines" })
keymap.set({ "n", "v" }, "K", "5k", { desc = "Move up 5 lines" })
keymap.set({ "n", "v" }, "L", "5l", { desc = "Move right 5 columns" })
keymap.set({ "n", "v" }, "H", "5h", { desc = "Move left 5 columns" })

-- Restore original J (join lines) to <leader>j
keymap.set("n", "<leader>j", "J", { desc = "Join lines" })

-- Navigate between windows
keymap.set("n", "<C-J>", "<C-W><C-J>", { desc = "Move to window below" })
keymap.set("n", "<C-K>", "<C-W><C-K>", { desc = "Move to window above" })
keymap.set("n", "<C-L>", "<C-W><C-L>", { desc = "Move to window right" })
keymap.set("n", "<C-H>", "<C-W><C-H>", { desc = "Move to window left" })

-- Navigate from terminal mode
keymap.set("t", "<C-J>", "<C-\\><C-N><C-W><C-J>", { desc = "Move to window below (from terminal)" })
keymap.set("t", "<C-K>", "<C-\\><C-N><C-W><C-K>", { desc = "Move to window above (from terminal)" })
keymap.set("t", "<C-L>", "<C-\\><C-N><C-W><C-L>", { desc = "Move to window right (from terminal)" })
keymap.set("t", "<C-H>", "<C-\\><C-N><C-W><C-H>", { desc = "Move to window left (from terminal)" })

-- System clipboard
keymap.set("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
keymap.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })

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

-- Window edge detection functions
local function at_left_edge()
    return vim.fn.winnr() == vim.fn.winnr("h")
end

local function at_right_edge()
    return vim.fn.winnr() == vim.fn.winnr("l")
end

local function at_top_edge()
    return vim.fn.winnr() == vim.fn.winnr("k")
end

local function at_bottom_edge()
    return vim.fn.winnr() == vim.fn.winnr("j")
end

-- Common function to set up all temporary keymaps
local function setup_window_mode_keymaps()
    local opts = { buffer = true, silent = true, nowait = true }
    local function with_desc(desc)
        return vim.tbl_extend("force", opts, { desc = desc })
    end

    -- Resize keymaps (lowercase) - work in normal and terminal mode
    vim.keymap.set({ "n", "t" }, "h", resize_and_continue("h"), with_desc("Resize window left"))
    vim.keymap.set({ "n", "t" }, "j", resize_and_continue("j"), with_desc("Resize window down"))
    vim.keymap.set({ "n", "t" }, "k", resize_and_continue("k"), with_desc("Resize window up"))
    vim.keymap.set({ "n", "t" }, "l", resize_and_continue("l"), with_desc("Resize window right"))

    -- Swap keymaps (uppercase) - work in normal and terminal mode
    vim.keymap.set({ "n", "t" }, "H", swap_and_continue("h"), with_desc("Swap window left"))
    vim.keymap.set({ "n", "t" }, "J", swap_and_continue("j"), with_desc("Swap window down"))
    vim.keymap.set({ "n", "t" }, "K", swap_and_continue("k"), with_desc("Swap window up"))
    vim.keymap.set({ "n", "t" }, "L", swap_and_continue("l"), with_desc("Swap window right"))

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
        -- Delete terminal mode keymaps
        pcall(vim.keymap.del, "t", "h", { buffer = true })
        pcall(vim.keymap.del, "t", "j", { buffer = true })
        pcall(vim.keymap.del, "t", "k", { buffer = true })
        pcall(vim.keymap.del, "t", "l", { buffer = true })
        pcall(vim.keymap.del, "t", "H", { buffer = true })
        pcall(vim.keymap.del, "t", "J", { buffer = true })
        pcall(vim.keymap.del, "t", "K", { buffer = true })
        pcall(vim.keymap.del, "t", "L", { buffer = true })
        pcall(vim.keymap.del, "n", "<ESC>", { buffer = true })
        pcall(vim.keymap.del, "t", "<ESC>", { buffer = true })
    end

    vim.keymap.set("n", "<ESC>", exit_window_mode, with_desc("Exit window resize/swap mode"))
    vim.keymap.set("t", "<ESC>", function()
        vim.cmd("stopinsert") -- Exit terminal mode
        exit_window_mode()
    end, with_desc("Exit window resize/swap mode"))
end

-- Simple directional resize - always resize right/bottom edges
local function directional_resize(direction, amount)
    amount = amount or 2 -- Default resize amount

    if direction == "h" then
        -- Shrink window (move right edge left)
        vim.cmd(string.format("vertical resize -%d", amount))
    elseif direction == "l" then
        -- Expand window (move right edge right)
        vim.cmd(string.format("vertical resize +%d", amount))
    elseif direction == "k" then
        -- Shrink window (move bottom edge up)
        vim.cmd(string.format("resize -%d", amount))
    elseif direction == "j" then
        -- Expand window (move bottom edge down)
        vim.cmd(string.format("resize +%d", amount))
    end

    -- Defer redraw to avoid race conditions with terminal resize events
    vim.schedule(function()
        vim.cmd("redraw")
    end)
end

resize_and_continue = function(direction)
    return function()
        directional_resize(direction) -- Use custom directional resize
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

-- Window resizing (works in both normal and terminal mode)
keymap.set({ "n", "t" }, "<C-w>h", resize_and_continue("h"), { desc = "Resize left (repeatable)" })
keymap.set({ "n", "t" }, "<C-w>j", resize_and_continue("j"), { desc = "Resize down (repeatable)" })
keymap.set({ "n", "t" }, "<C-w>k", resize_and_continue("k"), { desc = "Resize up (repeatable)" })
keymap.set({ "n", "t" }, "<C-w>l", resize_and_continue("l"), { desc = "Resize right (repeatable)" })

-- Window swapping with capital letters (C-w H/J/K/L) - stays in window mode
keymap.set({ "n", "t" }, "<C-w>H", swap_and_continue("h"), { desc = "Swap window left (repeatable)" })
keymap.set({ "n", "t" }, "<C-w>J", swap_and_continue("j"), { desc = "Swap window down (repeatable)" })
keymap.set({ "n", "t" }, "<C-w>K", swap_and_continue("k"), { desc = "Swap window up (repeatable)" })
keymap.set({ "n", "t" }, "<C-w>L", swap_and_continue("l"), { desc = "Swap window right (repeatable)" })

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
keymap.set("v", "<leader>enum", "senumerate()<esc>P?for\\s<cr>3lai, <esc>/enumerate<cr>", { desc = "Wrap for-loop iterable in enumerate()" })
keymap.set("v", "<leader>arg", "xmai()<esc>P`ai", { desc = "Wrap selection in parentheses" })
keymap.set("v", "<leader>next", "snext(iter(<esc>pa))<esc>", { desc = "Wrap selection in next(iter(...))" })

keymap.set("n", "<leader>gb", function()
    require("gitsigns").blame_line({ full = true })
end, { desc = "Git blame current line" })

keymap.set("n", "<leader>gp", function()
    require("gitsigns").preview_hunk()
end, { desc = "Preview git hunk" })

keymap.set("n", "<leader>gd", function()
    local gitsigns = require("gitsigns")
    gitsigns.toggle_deleted()
    gitsigns.toggle_linehl()
end, { desc = "Toggle deleted lines in git diff" })

keymap.set("n", "<leader>gcb", function()
    local gitsigns = require("gitsigns")
    vim.ui.select({ "current", "main", "unpushed" }, { prompt = "Gitsigns diff base:" }, function(choice)
        if choice == "current" then
            gitsigns.change_base(nil, true)
        elseif choice == "main" then
            local has_main = vim.fn.system("git rev-parse --verify main 2>/dev/null") ~= ""
            gitsigns.change_base(has_main and "main" or "master", true)
        elseif choice == "unpushed" then
            gitsigns.change_base("@{u}", true) -- diff against the upstream tracking branch
        end
    end)
end, { desc = "Change gitsigns diff base" })

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

keymap.set("n", "<leader>rg", 'y:%s/<C-R>"//g<left><left>', { desc = "Replace yanked word in whole file" })
keymap.set("n", "<leader>rl", 'y:s/<C-R>"//g<left><left>', { desc = "Replace yanked word in current line" })

keymap.set("n", "<leader>ti", "A  # type: ignore<ESC>", { desc = "Append type: ignore comment" })
