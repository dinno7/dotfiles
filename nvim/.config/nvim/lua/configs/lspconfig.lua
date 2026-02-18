local configs = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"

-- INFO: Server options
local tsserverOptions = require "configs.lspservers.tsserver"
local goplsOptions = require "configs.lspservers.gopls"
local cspellOptions = require "configs.lspservers.cspell"
local rustAnalyzerOptions = require "configs.lspservers.rustanalyzer"

local x = vim.diagnostic.severity
vim.diagnostic.config {
  virtual_text = {
    prefix = "",
    severity = { x.WARN, x.ERROR },
  },
  signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } },
  underline = true,
  float = { border = "single" },
}

-- INFO: LSP servers
local servers = {
  ts_ls = tsserverOptions,
  gopls = goplsOptions,
  cspell_lsp = cspellOptions,
  rust_analyzer = rustAnalyzerOptions,
  html = {},
  cssls = {},
  bashls = {},
  just = {}, -- Just lsp(justfile)
  biome = {},
  eslint = {},
  tailwindcss = {},
  dockerls = {},
  emmet_ls = {
    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "vue", "sass", "scss", "less", "svelte" },
  },
  yamlls = {
    filetypes = {
      "yaml",
      "yml",
    },
  },
  postgres_lsp = {
    cmd = { "postgres-language-server", "lsp-proxy" },
  },
  docker_compose_language_service = {
    filetypes = { "yml.compose", "yml.docker-compose", "yaml.compose", "yaml.docker-compose" },
  },
}

-- INFO: Initiate all defined servers
for name, opts in pairs(servers) do
  opts.on_init = configs.on_init
  opts.on_attach = configs.on_attach
  opts.capabilities = configs.capabilities
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end
