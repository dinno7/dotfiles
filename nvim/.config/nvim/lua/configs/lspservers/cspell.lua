local options = {
  cmd = { "cspell-lsp", "--stdio" },
  filetypes = {
    "lua",
    "go",
    "rust",
    "txt",
    "text", -- the real filetype name of plain text files ("txt" is kept for backwards compat)
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
