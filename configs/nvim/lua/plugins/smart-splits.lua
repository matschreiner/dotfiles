return {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
    init = function()
        -- Set this BEFORE plugin loads to prevent auto-detection of tmux
        vim.g.smart_splits_multiplexer_integration = false
    end,
    config = function()
        require("smart-splits").setup({
            -- Disable all multiplexer integration (tmux, wezterm, etc.)
            -- This prevents Neovim window operations from affecting terminal panes
            ignored_filetypes = {},
            ignored_buftypes = { "nofile" },

            -- Explicitly disable tmux integration
            at_edge = "stop", -- Don't wrap to tmux panes at edge
            multiplexer_integration = false,

            -- Enable cursor to follow buffer content when swapping windows
            cursor_follows_swapped_bufs = true,
        })
    end,
}
