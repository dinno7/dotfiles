local options = {
  formatters_by_ft = {
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
    lua = { "stylua" },
    -- vue = { "volar" },
    -- python = { "isort", "black" },
    -- cpp = { "clang-format" },
    go = {
      "golines",
      "goimports",
      "gofumpt",
    },
  },
  format_on_save = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  },
}

return options
