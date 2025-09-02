local M = {}

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
