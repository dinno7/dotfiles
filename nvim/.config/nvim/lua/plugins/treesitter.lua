return {
  "nvim-treesitter/nvim-treesitter",
  opts = function()
    local opts = require "nvchad.configs.treesitter"
    opts.ensure_installed = {
      "go",
      "lua",
      "sql",
      "vim",
      "tsx",
      "css",
      "html",
      "rust",
      "bash",
      "json",
      "yaml",
      "just",
      "tmux",
      "jsonc",
      "regex",
      "vimdoc",
      "markdown",
      "gitcommit",
      "git_rebase",
      "dockerfile",
      "typescript",
      "javascript",
    }
    return opts
  end,
}
