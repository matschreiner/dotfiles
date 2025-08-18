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
