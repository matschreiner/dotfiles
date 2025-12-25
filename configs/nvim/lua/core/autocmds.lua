-- Enable cursorline in active window
local cursorLineGroup = vim.api.nvim_create_augroup("AddCursorLine", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
    pattern = "*",
    command = "setlocal cursorline",
    group = cursorLineGroup,
})

vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
    command = "setlocal nocursorline",
    pattern = "*",
    group = cursorLineGroup,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "yaml",
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.expandtab = true
    end,
})

-- Dart folding configuration
vim.api.nvim_create_autocmd("FileType", {
    pattern = "dart",
    callback = function(args)
        -- Check if Treesitter parser is available
        local has_parser = pcall(vim.treesitter.get_parser, args.buf, "dart")

        if has_parser then
            -- Use Treesitter-based folding
            vim.opt_local.foldmethod = "expr"
            vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        else
            -- Fallback to indent-based folding if parser not available
            vim.opt_local.foldmethod = "indent"
            print("Treesitter parser for Dart not found, using indent folding")
        end

        vim.opt_local.foldlevel = 99
        vim.opt_local.foldlevelstart = 99
        vim.opt_local.foldenable = true
    end,
})

-- -- Change background to black when window loses focus
-- local focusGroup = vim.api.nvim_create_augroup("WindowFocusBackground", { clear = true })
--
-- vim.api.nvim_create_autocmd("FocusLost", {
--     pattern = "*",
--     callback = function()
--         vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
--     end,
--     group = focusGroup,
-- })
--
-- vim.api.nvim_create_autocmd("FocusGained", {
--     pattern = "*",
--     callback = function()
--         -- Restore the gruvbox background color
--         vim.api.nvim_set_hl(0, "Normal", { bg = "#282828" })
--     end,
--     group = focusGroup,
-- })
