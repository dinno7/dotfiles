return {
  "nvim-treesitter/nvim-treesitter",
  opts = function()
    local opts = require "nvchad.configs.treesitter"
    opts.ensure_installed = {
      "go",
      "vim",
      "lua",
      "tsx",
      "css",
      "html",
      "bash",
      "vimdoc",
      "javascript",
      "typescript",
    }
    return opts
  end,
}
