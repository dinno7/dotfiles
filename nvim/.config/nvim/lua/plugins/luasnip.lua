return {
  -- snippet plugin
  "L3MON4D3/LuaSnip",
  opts = { history = true, updateevents = "TextChanged,TextChangedI" },
  config = function()
    require("luasnip.loaders.from_vscode").load_standalone {
      path = vim.g.vscode_snippets_standalone_path or "",
    }
  end,
}
