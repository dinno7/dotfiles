local options = {
  cmd = { "cspell-lsp", "--stdio" },
  filetypes = {
    "lua",
    "go",
    "rust",
    "txt",
    "sql",
    "python",
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
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
