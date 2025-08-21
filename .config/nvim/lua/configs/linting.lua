local lint = require "lint"

lint.linters_by_ft = {
  go = { "golangcilint" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

local function try_lint()
  lint.try_lint()
  -- lint.try_lint "cspell"
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = lint_augroup,
  callback = try_lint,
})

vim.keymap.set("n", "<leader>l", try_lint, { desc = "Trigger linting for current file" })
