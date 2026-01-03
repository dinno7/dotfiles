require "nvchad.options"

local o = vim.opt

o.termbidi = true

o.cursorlineopt = "both" -- to enable cursorline!

-- INFO: Fold options
o.foldcolumn = "auto:9"
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true
o.fillchars = [[eob: ,fold: ,foldopen:,foldsep:│,foldclose:]]

o.relativenumber = true

o.colorcolumn = "80"

-- INFO: Enable spell checker
o.spelllang = "en_us"
o.spell = true


-- INFO: Set custom snippets(vscode-like) path
vim.g.vscode_snippets_path = vim.fn.stdpath "config" .. "/snippets"
