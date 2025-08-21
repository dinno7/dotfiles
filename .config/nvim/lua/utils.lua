local M = {}
local api = vim.api

function M.blameVirtText()
  local ft = vim.fn.expand "%:h:t" -- get the current file extension
  if ft == "" then -- if we are in a scratch buffer or unknown filetype
    return
  end
  if ft == "bin" then -- if we are in nvim's terminal window
    return
  end
  api.nvim_buf_clear_namespace(0, 2, 0, -1) -- clear out virtual text from namespace 2 (the namespace we will set later)
  local currFile = vim.fn.expand "%"
  local line = api.nvim_win_get_cursor(0)
  local blame = vim.fn.system(string.format("git blame -c -L %d,%d %s", line[1], line[1], currFile))
  local hash = vim.split(blame, "%s")[1]
  local cmd = string.format("git show %s ", hash) .. " --format='%an | %ar | %s'"
  if hash == "00000000" then
    text = "Not Committed Yet"
  else
    text = vim.fn.system(cmd)
    text = vim.split(text, "\n")[1]
    if text:find "fatal" then -- if the call to git show fails
      text = "Not Committed Yet"
    end
  end
  -- api.nvim_buf_set_virtual_text(0, 2, line[1] - 1, nil, {}) -- set virtual text for namespace 2 with the content from git and assign it to the higlight group 'GitLens'
  api.nvim_buf_set_virtual_text(0, 2, line[1] - 1, { { text } }, {})
end

function M.clearBlameVirtText() -- important for clearing out the text when our cursor moves
  api.nvim_buf_clear_namespace(0, 2, 0, -1)
end

-- INFO: Function to convert binary data to hex view
function M.binaryToHex(binary_string)
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
function M.isBinary(filename)
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

return M
