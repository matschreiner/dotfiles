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

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local bufmap = function(mode, lhs, rhs)
            local opts = { buffer = event.buf }
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- You can find details of these function in the help page
        -- see for example, :help vim.lsp.buf.hover()

        -- Trigger code completion
        bufmap("i", "<C-Space>", "<C-x><C-o>")

        -- -- Display documentation of the symbol under the cursor
        -- bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")

        -- Jump to the definition
        bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")

        -- Jump to declaration
        bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")

        -- Lists all the implementations for the symbol under the cursor
        bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")

        -- Jumps to the definition of the type symbol
        bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")

        -- Lists all the references
        bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")

        -- Displays a function's signature information
        bufmap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")

        -- Renames all references to the symbol under the cursor
        bufmap("n", "R", "<cmd>lua vim.lsp.buf.rename()<cr>")

        -- Format current file
        bufmap("n", "<F3>", "<cmd>lua vim.lsp.buf.format()<cr>")

        -- Selects a code action available at the current cursor position
        bufmap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "yaml",
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.expandtab = true
    end,
})
