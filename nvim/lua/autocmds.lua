local autocmd = vim.api.nvim_create_autocmd
local utils = require "utils"

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

-- INFO: Autocmd to open binary files in hex view
autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local filename = vim.api.nvim_buf_get_name(0)
    if utils.isBinary(filename) then
      -- Read file contents
      local file = io.open(filename, "rb")
      if not file then
        return
      end
      local content = file:read "*all"
      file:close()

      -- Convert to hex view
      local hex_content = utils.binaryToHex(content)

      -- Replace buffer content with hex view
      vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(hex_content, "\n"))

      -- Set buffer as non-modifiable
      vim.bo.modifiable = false
      vim.bo.modified = false

      -- Set filetype for potential syntax highlighting
      vim.bo.filetype = "hexdump"
    end
  end,
})

-- NOTE: Add Git blame stuff(GitLens)
-- local git_blame_grp = vim.api.nvim_create_augroup("GitBlameAnnotations", { clear = true })

-- NOTE: Show blame text on CursorHold
-- autocmd("CursorHold", {
--   group = git_blame_grp,
--   pattern = "*",
--   desc = "Display Git blame virtual text",
--   callback = function()
--     require("utils").blameVirtText()
--   end,
-- })
--
-- -- NOTE: Clear blame text on cursor move (normal or insert)
-- autocmd({ "CursorMoved", "CursorMovedI" }, {
--   group = git_blame_grp,
--   pattern = "*",
--   desc = "Clear Git blame virtual text",
--   callback = function()
--     require("utils").clearBlameVirtText()
--   end,
-- })
