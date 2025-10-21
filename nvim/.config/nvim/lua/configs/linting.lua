local lint = require "lint"

lint.linters_by_ft = {
  ["*"] = { "typos" },
  go = { "golangcilint" },
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

local function try_lint()
  lint.try_lint()
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = lint_augroup,
  callback = try_lint,
})

vim.keymap.set("n", "<leader>l", try_lint, { desc = "Trigger linting for current file" })
