return {
	"preservim/nerdcommenter",
	config = function()
		vim.g.NERDDefaultAlign = "left"
		vim.g.NERDCommentEmptyLines = 1
		vim.g.NERDSpaceDelims = 1
		vim.g.NERDCompactSexyComs = 1
		vim.g.NERDTrimTrailingWhitespace = 1
		vim.g.NERDCommentBadWhitespace = 1
		vim.api.nvim_set_keymap("v", "<C-x>", "<Plug>NERDCommenterToggle", { noremap = false, silent = true })
		vim.api.nvim_set_keymap("n", "<C-x>", "<Plug>NERDCommenterToggle", { noremap = false, silent = true })
	end,
}
