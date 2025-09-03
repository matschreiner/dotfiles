return {
    "ggandor/leap.nvim",
    config = function()
        local leap = require("leap")
        leap.opts.case_sensitive = false
        vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-anywhere)")
        vim.api.nvim_set_hl(0, "LeapMatch", { link = "Comment" })
        leap.init_hl()
        leap.auto_jump = false
    end,
}
