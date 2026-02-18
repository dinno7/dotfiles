local options = {
  formatters_by_ft = {
    -- Use the "_" filetype to run formatters on filetypes that don't have other formatters configured.
    ["_"] = { "trim_whitespace" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },
    css = { "prettierd" },
    html = { "prettierd" },
    json = { "prettierd" },
    yaml = { "prettierd" },
    markdown = { "prettierd" },
    graphql = { "prettierd" },
    rust = { "rustfmt", lsp_format = "fallback" },
    lua = { "stylua" },
    sh = { "shfmt" },
    zsh = { "shfmt" },
    sql = { "pg_format" },
    go = {
      "golangci-lint",
      "golines",
      "goimports",
      "gofumpt",
    },
  },
  format_after_save = {
    lsp_format = "fallback",
    timeout_ms = 500,
  },
}

return options
