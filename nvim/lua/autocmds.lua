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

-- INFO: Function to convert binary data to hex view
local function binary_to_hex(binary_string)
  local hex_view = ""
  local ascii_view = ""
  local address = 0

  for i = 1, #binary_string, 16 do
    -- Address
    hex_view = hex_view .. string.format("%08x: ", address)

    -- Hex values
    for j = i, math.min(i + 15, #binary_string) do
      local byte = string.byte(binary_string:sub(j, j))
      hex_view = hex_view .. string.format("%02x ", byte)

      -- ASCII representation
      if byte >= 32 and byte <= 126 then
        ascii_view = ascii_view .. string.char(byte)
      else
        ascii_view = ascii_view .. "."
      end
    end

    -- Pad hex view if less than 16 bytes
    if #binary_string - i + 1 < 16 then
      hex_view = hex_view .. string.rep("   ", 16 - (#binary_string - i + 1))
    end

    hex_view = hex_view .. " " .. ascii_view .. "\n"
    ascii_view = ""
    address = address + 16
  end

  return hex_view
end

-- INFO: Function to check if file is binary
local function is_binary(filename)
  local file = io.open(filename, "rb")
  if not file then
    return false
  end

  local chunk = file:read(1024)
  file:close()

  if not chunk then
    return false
  end

  -- Check for null bytes or high number of non-printable characters
  local non_printable = 0
  for i = 1, #chunk do
    local byte = string.byte(chunk:sub(i, i))
    if byte == 0 or (byte < 32 and byte ~= 9 and byte ~= 10 and byte ~= 13) then
      non_printable = non_printable + 1
    end
  end

  return (non_printable / #chunk) > 0.3
end

-- INFO: Autocmd to open binary files in hex view
autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local filename = vim.api.nvim_buf_get_name(0)
    if is_binary(filename) then
      -- Read file contents
      local file = io.open(filename, "rb")
      if not file then
        return
      end
      local content = file:read "*all"
      file:close()

      -- Convert to hex view
      local hex_content = binary_to_hex(content)

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
