return {
    "neovim/nvim-lspconfig",
    config = function()
        -- NEW API: no require("lspconfig")
        -- Configure lua_ls to use current working directory as root
        vim.lsp.config.lua_ls = {
            root_dir = function()
                return vim.uv.cwd()
            end,
        }

        vim.lsp.enable("lua_ls")
        vim.lsp.enable("rust_analyzer")
        vim.lsp.enable("clangd")
        vim.lsp.enable("eslint")
        vim.lsp.enable("rome")
        vim.lsp.enable("dartls")
        -- vim.lsp.enable("basedpyright")
        -- vim.lsp.enable("pyright")

        -- Diagnostics keymaps
        vim.keymap.set("n", "<space>d", vim.diagnostic.open_float)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
        vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

        -- Buffer-local LSP keymaps on attach
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                local opts = { buffer = ev.buf }
                vim.keymap.set("n", "<c-b>", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "<leader><c-b>", function()
                    vim.cmd("vsplit")
                    vim.lsp.buf.declaration()
                end, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "<space>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
                vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<space>f", function()
                    vim.lsp.buf.format({ async = true })
                end, opts)
            end,
        })
    end,
}

-- return {
--     "neovim/nvim-lspconfig",
--     config = function()
--         local lspconfig = require("lspconfig")
--
--         lspconfig.lua_ls.setup({})
--         lspconfig.rust_analyzer.setup({})
--         lspconfig.clangd.setup({})
--         lspconfig.eslint.setup({})
--         lspconfig.rome.setup({})
--         -- lspconfig.basedpyright.setup({})
--         -- lspconfig.pyright.setup({})
--
--         vim.keymap.set("n", "<space>d", vim.diagnostic.open_float)
--         vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
--         vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
--         vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)
--
--         vim.api.nvim_create_autocmd("LspAttach", {
--             group = vim.api.nvim_create_augroup("UserLspConfig", {}),
--             callback = function(ev)
--                 vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
--                 local opts = { buffer = ev.buf }
--                 vim.keymap.set("n", "<c-b>", vim.lsp.buf.declaration, opts)
--                 vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
--                 vim.keymap.set("n", "<c-k>", vim.lsp.buf.hover, opts)
--                 vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
--                 vim.keymap.set("n", "<space>wl", function()
--                     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--                 end, opts)
--                 vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
--                 vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
--                 vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
--                 vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
--                 vim.keymap.set("n", "<space>f", function()
--                     vim.lsp.buf.format({ async = true })
--                 end, opts)
--             end,
--         })
--     end,
-- }
