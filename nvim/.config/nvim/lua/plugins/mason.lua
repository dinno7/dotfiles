return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "stylua",
      "emmet-ls",
      "eslint-lsp",
      "prettierd",
      "shfmt",
      "lua-language-server",
      "bash-language-server",
      "typescript-language-server",
      "vue-language-server",
      -- > GO lang
      "gopls",
      "gofumpt",
      "goimports",
      "golangci-lint",
      "golines",
      -- > Rust
      "rust-analyzer",
      -- > Others
      "cspell",
      -- "clang-format",
      -- "clangd",
      -- "vue-language-server",
    },
  },
}
