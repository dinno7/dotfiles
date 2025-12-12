require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

-- INFO: Close all folds in entering buffer
-- autocmd("BufRead", {
--   callback = function()
--     vim.cmd [[ silent! foldclose! ]]
--     local bufnr = vim.api.nvim_get_current_buf()
--     -- make sure buffer is attached
--     vim.wait(100, function()
--       require("ufo").attach(bufnr)
--     end)
--     if require("ufo").hasAttached(bufnr) then
--       local winid = vim.api.nvim_get_current_win()
--       local method = vim.wo[winid].foldmethod
--       if method == "diff" or method == "marker" then
--         require("ufo").closeAllFolds()
--         return
--       end
--       -- getFolds returns a Promise if providerName == 'lsp', use vim.wait in this case
--       local ok, ranges = pcall(require("ufo").getFolds, bufnr, "treesitter")
--       if ok and ranges then
--         if require("ufo").applyFolds(bufnr, ranges) then
--           pcall(require("ufo").closeAllFolds)
--         end
--       end
--     end
--   end,
-- })

-- INFO: Restore cursor position
autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
        line > 1
        and line <= vim.fn.line "$"
        and vim.bo.filetype ~= "commit"
        and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})

-- INFO: Highlight in yank
autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank { higroup = "HLOnYank", timeout = 250 }
  end,
})

autocmd("BufDelete", {
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.cmd "Nvdash"
    end
  end,
})
