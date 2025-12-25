return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup({
            defaults = {
                path_display = { "truncate " },
                file_ignore_patterns = { "venv", "node_modules", ".git" },
                -- Disable treesitter in previewer (compatibility fix)
                preview = {
                    treesitter = false,
                },
            },
        })
        telescope.load_extension("fzf")

        vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
        vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
        vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
        vim.keymap.set(
            "n",
            "<leader>fc",
            "<cmd>Telescope grep_string<cr>",
            { desc = "Find string under cursor in cwd" }
        )

        local function select_directory(callback)
            require("telescope").extensions.file_browser.file_browser({
                path = vim.fn.getcwd(),
                prompt_title = "Select Directory",
                select_buffer = true,
                dirs_only = true,
            })
        end

        local function find_files_in_dir()
            require("telescope.builtin").find_files({
                prompt_title = "Find Files in Directory",
                cwd = vim.fn.input("Directory: ", vim.fn.getcwd(), "dir"),
            })
        end

        local function live_grep_in_dir()
            require("telescope.builtin").live_grep({
                prompt_title = "Live Grep in Directory",
                cwd = vim.fn.input("Directory: ", vim.fn.getcwd(), "dir"),
            })
        end

        vim.keymap.set("n", "<leader>fdf", find_files_in_dir, { desc = "Find files in a chosen directory" })
        vim.keymap.set("n", "<leader>fds", live_grep_in_dir, { desc = "Live grep in a chosen directory" })
    end,
}
