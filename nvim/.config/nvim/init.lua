vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- load autocmds
require "nvchad.autocmds"
require "autocmds"

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

vim.schedule(function()
  require "mappings"
end)
