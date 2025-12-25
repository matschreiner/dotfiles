return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                theme = "gruvbox", -- or "auto" to match current colorscheme
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
                icons_enabled = true,
                globalstatus = false, -- Each window gets its own statusline
                disabled_filetypes = { statusline = { "NvimTree", "lazy" } },
            },
            sections = {
                lualine_a = { { "mode", icon = "" } },
                lualine_b = { "branch", "diff" },
                lualine_c = { { "filename", path = 1 } },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { { "location", icon = "" } },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            extensions = { "nvim-tree", "quickfix" },
        })
    end,
}
