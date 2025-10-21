local options = {
  cmd = { "cspell-lsp", "--stdio" },
  filetypes = {
    "lua",
    "go",
    "python",
    "javascript",
    "typescript",
    "html",
    "css",
    "json",
    "yaml",
    "markdown",
    "gitcommit",
  },
  root_markers = { ".git" },
}

return options
