require "nvchad.options"

local o = vim.opt

o.cursorlineopt = "both" -- to enable cursorline!

-- INFO: Fold options
o.foldcolumn = "auto:9"
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true
o.fillchars = [[eob: ,fold: ,foldopen:,foldsep:│,foldclose:]]

o.relativenumber = true

o.colorcolumn = "80"

-- INFO: Enable mouse mapping to vim-multi
vim.g.VM_mouse_mappings = 1

-- INFO: Enable spell checker
o.spelllang = "en_us"
o.spell = true

-- INFO: Get custom snippets from VSCode
vim.g.vscode_snippets_standalone_path = "~/.config/nvim/dinno.code-snippets"

-- INFO: Optional: Add a command to toggle hex view
--
-- vim.api.nvim_create_user_command("ToggleHexView", function()
--   if vim.bo.filetype == "hexdump" then
--     -- Reopen the file normally
--     vim.cmd "edit!"
--   else
--     -- Trigger the hex view conversion
--     local filename = vim.api.nvim_buf_get_name(0)
--     if is_binary(filename) then
--       vim.cmd "e"
--     else
--       print "This file is not detected as binary."
--     end
--   end
-- end, {})
--
-- INFO: Optional: Map a key to toggle hex view
--
-- vim.api.nvim_set_keymap("n", "u", ":ToggleHexView<CR>", { noremap = true, silent = true })
