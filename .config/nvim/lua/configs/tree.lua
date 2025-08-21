local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  -- vim.keymap.set("n", "l", api.node.open.edit, opts "Open Preview")
  vim.keymap.set("n", "Tab", api.node.open.preview, opts "Open File")
  vim.keymap.set("n", "l", api.node.open.edit, opts "Open File")
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Close directory")
  vim.keymap.set("n", "?", api.tree.toggle_help, opts "Help")
  -- vim.keymap.set("n", "<C-h>", api.tree.horizontal, opts "Open horizontal tab")
end

return my_on_attach
