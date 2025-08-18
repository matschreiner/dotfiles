return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable a K
      keys[#keys + 1] = { "K", false }
      keys[#keys + 1] = { "<c-K>", vim.lsp.buf.hover, desc = "Hover" }
    end,
  },
  { "echasnovski/mini.animate", enabled = false },
}
