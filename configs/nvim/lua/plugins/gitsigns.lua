return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            linehl = false, -- toggled on alongside show_deleted via <leader>gd, not always on
            diff_opts = {
                internal = false, -- shell out to real `git diff` instead of gitsigns' own differ, which interleaves add/remove lines differently (word_diff needs internal=true, so it's not usable here)
            },
        })
        -- Background-only tints, so normal syntax highlighting still shows
        -- through the text instead of being overridden by a single color.
        vim.api.nvim_set_hl(0, "GitSignsAddLn", { bg = "#2d3a28" })
        vim.api.nvim_set_hl(0, "GitSignsChangeLn", { bg = "#2d3a28" })
        vim.api.nvim_set_hl(0, "GitSignsDeleteVirtLn", { bg = "#472525" })
    end,
    -- signs = {
    --     add = { text = "┃" },
    --     change = { text = "┃" },
    --     delete = { text = "_" },
    --     topdelete = { text = "‾" },
    --     changedelete = { text = "~" },
    --     untracked = { text = "┆" },
    -- },
    -- signs_staged = {
    --     add = { text = "┃" },
    --     change = { text = "┃" },
    --     delete = { text = "_" },
    --     topdelete = { text = "‾" },
    --     changedelete = { text = "~" },
    --     untracked = { text = "┆" },
    -- },
    -- signs_staged_enable = true,
    -- signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    -- numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    -- linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    -- word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    -- watch_gitdir = {
    --     follow_files = true,
    -- },
    -- auto_attach = true,
    -- attach_to_untracked = false,
    -- current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    -- current_line_blame_opts = {
    --     virt_text = true,
    --     virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    --     delay = 1000,
    --     ignore_whitespace = false,
    --     virt_text_priority = 100,
    --     use_focus = true,
    -- },
    -- current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
    -- sign_priority = 6,
    -- update_debounce = 100,
    -- status_formatter = nil, -- Use default
    -- max_file_length = 40000, -- Disable if file is longer than this (in lines)
    -- preview_config = {
    --     -- Options passed to nvim_open_win
    --     border = "single",
    --     style = "minimal",
    --     relative = "cursor",
    --     row = 0,
    --     col = 1,
    -- },
}
