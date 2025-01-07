return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = true,
				timeout_ms = 500,
			},
		})

		local format_buffer = function()
			local buffer_id = vim.api.nvim_get_current_buf()
			conform.format({ bufnr = buffer_id })
		end

		vim.keymap.set({ "n", "v" }, "<leader>b", format_buffer, { noremap = true, silent = true })
	end,
}
