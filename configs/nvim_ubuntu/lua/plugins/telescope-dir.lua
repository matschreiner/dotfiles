return {
	"princejoogie/dir-telescope.nvim",
	-- telescope.nvim is a required dependency
	requires = { "nvim-telescope/telescope.nvim" },
	config = function()
		require("dir-telescope").setup({
			-- these are the default options set
			hidden = true,
			no_ignore = false,
			show_preview = true,
		})
		vim.keymap.set("n", "<leader>fds", "<cmd>GrepInDirectory<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>fdf", "<cmd>FileInDirectory<CR>", { noremap = true, silent = true })
	end,
}
