return {
    "preservim/nerdcommenter",
    init = function()
        vim.g.NERDCreateDefaultMappings = 0
        vim.g.NERDDefaultAlign = "left"
        vim.g.NERDCommentEmptyLines = 1
        vim.g.NERDSpaceDelims = 1
        vim.g.NERDCompactSexyComs = 1
        vim.g.NERDTrimTrailingWhitespace = 1
        vim.g.NERDCommentBadWhitespace = 1
    end,
    config = function()
        vim.keymap.set({ "n", "v" }, "<C-x>", "<Plug>NERDCommenterToggle", { silent = true })
    end,
}
