local configs = require "nvchad.configs.lspconfig"

-- INFO: Replace NvChad renamer with Lspsaga renamer
local original_on_attach = configs.on_attach
local function on_attach(client, bufnr)
  -- Call the original NvChad on_attach first
  original_on_attach(client, bufnr)
  -- Now remove the <leader>ra mapping that NvChad set up, i want set Lspsaga renamer
  pcall(vim.keymap.del, "n", "<leader>ra", { buffer = bufnr }) -- INFO: Handled by lspsaga
  pcall(vim.keymap.del, "n", "gd", { buffer = bufnr }) -- INFO: Handled by lspsaga
end

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
  -- rust_analyzer = rustAnalyzerOptions, --> It will configur with `rustaceanvim`
  html = {},
  cssls = {},
  bashls = {},
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
  eslint = {},
  vue_ls = {}, --> vue-lsp
  -- vuels = {}, --> vetur
  biome = {},
  just = {}, -- Just lsp(justfile)
  taplo = {}, -- Toml files
  tailwindcss = {},
  docker_compose_language_service = {
    filetypes = { "yml.compose", "yml.docker-compose", "yaml.compose", "yaml.docker-compose" },
  },
}

-- require("lspconfig").postgres_lsp.setup {
--   cmd = { "postgres-language-server", "lsp-proxy" },
-- }
-- INFO: Initiate all defined servers
for name, opts in pairs(servers) do
  opts.on_init = configs.on_init
  opts.on_attach = on_attach
  opts.capabilities = configs.capabilities
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end
