local options = {
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly", -- Faster; change to "workspace" if needed
        typeCheckingMode = "standard", -- or "strict" / "basic"
      },
      -- Disable formatting/linting in LSP; let conform + nvim-lint handle it
      disableLanguageServices = false,
      disableOrganizeImports = true, -- Ruff handles import sorting
    },
  },
  -- Optional: Auto-detect virtual environments
  before_init = function(_, config)
    local venv = vim.fn.finddir(".venv", ".;")
    if venv ~= "" then
      config.settings.python = config.settings.python or {}
      config.settings.python.pythonPath = venv .. "/bin/python"
    end
  end,
}

return options
