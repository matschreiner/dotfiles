return {
  "unblevable/quick-scope",
  config = function()
    local function set_hl()
      vim.api.nvim_set_hl(0, "QuickScopePrimary", { fg = "#d3869b", bold = true })
      vim.api.nvim_set_hl(0, "QuickScopeSecondary", { fg = "#83a598", bold = true })

    end
    set_hl()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hl })
  end,
}
