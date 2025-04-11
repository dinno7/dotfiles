local util = require "lspconfig/util"
local options = {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedvariable = true,
        unreachable = true,
        unusedparams = true,

        -- useany = true,
        -- unusedwrite = true,
        -- ST1003 = true,
        -- undeclaredname = true,
        -- fillreturns = true,
        -- nonewvars = true,
        -- fieldalignment = false,
        -- shadow = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}

return options
