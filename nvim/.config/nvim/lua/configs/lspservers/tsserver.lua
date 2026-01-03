local TSOrganizeImports = function()
  vim.lsp.buf.code_action({
    apply = true,
    context = {
      only = { "source.organizeImports.ts" },
      diagnostics = {},
    },
  })
end

local TSRemoveUnused = function()
  vim.lsp.buf.code_action({
    apply = true,
    context = {
      only = { "source.removeUnused.ts" },
      diagnostics = {},
    },
  })
end

-- local function organize_imports()
--   local params = {
--     command = "_typescript.organizeImports",
--     arguments = { vim.api.nvim_buf_get_name(0) },
--     title = "",
--   }
--
--   local clients = vim.lsp.get_clients { name = "ts_ls" }
--   if #clients == 0 then
--     vim.notify("No ts_ls client found", vim.log.levels.ERROR)
--     return
--   end
--   local client = clients[1]
--   client:exec_cmd(params)
--   vim.notify("Imports sorted", vim.log.levels.INFO)
-- end

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
--   callback = organize_imports,
-- })

local options = {
  single_file_support = true,
  -- init_options = {
  --   preferences = {
  --     disableSuggestions = true,
  --   },
  -- },
  commands = {
    --   OrganizeImports = {
    --     organize_imports,
    --     description = "Organize Imports",
    --   },
    TSOrganizeImports = {
      TSOrganizeImports,
      description = "Organize Imports",
    },
    TSRemoveUnused = {
      TSRemoveUnused,
      description = "Remove unused",
    },
  },

  completions = {
    completeFunctionCalls = true,
  },

  settings = {
    javascript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },

    typescript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
  },
}

return options
