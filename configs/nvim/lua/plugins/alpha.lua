return {
    "goolord/alpha-nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.buttons.val = {
            dashboard.button("n", "New file", ":ene<CR>"),
            dashboard.button("r", "Recent files", ":Telescope oldfiles<CR>"),
            dashboard.button("f", "Find file", ":Telescope find_files<CR>"),
            dashboard.button("s", "Search in files", ":Telescope live_grep<CR>"),
            dashboard.button("e", "Explorer", ":NvimTreeToggle<CR>"),
            dashboard.button("q", "Quit", ":qa<CR>"),
        }

        dashboard.section.footer.val = "Neovim · " .. os.date("%Y-%m-%d")

        alpha.setup(dashboard.opts)
    end,
}
