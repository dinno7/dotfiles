return {
  "echasnovski/mini.files",
  lazy = false,
  version = false,
  config = function()
    local mini_files = require "mini.files"
    vim.keymap.set({ "n", "v", "i" }, "<C-b>", function()
      if not mini_files.close() then
        mini_files.open()
      end
    end)
    mini_files.setup()
  end,
}
