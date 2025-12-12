-- Change nvim tcd path to first arg path if provided
local nargs = vim.fn.argc()
if nargs == 1 then
  local arg = vim.fn.argv(0)
  if type(arg) == "string" and arg ~= "" then
    local stat = vim.uv.fs_stat(arg) -- nil | uv.uv_fs_t
    if stat then
      if stat.type == "directory" then
        vim.cmd.cd(arg)
      elseif stat.type == "file" then
        vim.cmd.cd(vim.fn.fnamemodify(arg, ":h"))
      end
    end
  end
end
