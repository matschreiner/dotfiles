return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        vim.opt.termguicolors = true
        require("nvim-tree").setup({
            on_attach = function(bufnr)
                local api = require("nvim-tree.api")
                api.config.mappings.default_on_attach(bufnr)
                pcall(vim.keymap.del, "n", "s", { buffer = bufnr })
                pcall(vim.keymap.del, "n", "S", { buffer = bufnr })
                vim.keymap.set(
                    "n",
                    "O",
                    require("nvim-tree.api").node.run.system,
                    { buffer = bufnr, desc = "Open in system app" }
                )
            end,

            view = {
                width = 35,
                relativenumber = false,
            },
            -- change folder arrow icons
            renderer = {
                full_name = true,
                indent_markers = {
                    enable = true,
                },
            },
            -- disable window_picker for
            -- explorer to work well with
            -- window splits
            actions = {
                open_file = {
                    window_picker = {
                        enable = false,
                    },
                },
            },
            filters = {
                dotfiles = true,
                custom = { ".DS_Store" },
            },
            git = {
                ignore = false,
            },
        })

        -- set keymaps
        vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
        vim.keymap.set(
            "n",
            "<leader>ef",
            "<cmd>NvimTreeFindFile<CR>",
            { desc = "Toggle file explorer on current file" }
        ) -- toggle file explorer on current file
        vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
        vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
    end,
}
