require "nvchad.mappings"
-- add yours here
local map = vim.keymap.set
local nomap = vim.keymap.del

-- NOTE: Have j and k navigate visual lines rather than logical ones
map("n", "j", "gj")
map("n", "k", "gk")

-- NOTE: Centered screen before go insert mode by `o` or `O`
map("n", "o", "zzo")
map("n", "O", "zzO")

-- NOTE: Keep window centered when going up/down
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- NOTE: Keep window centered when search next or previous
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- NOTE: Jump to matching pair easily in normal mode
map({ "n", "v" }, "<Tab>", "%", { desc = "Jump to matching pair easily in normal mode" })

-- NOTE: Word cases
map("i", "<c-t>", "<esc>b~lea", { desc = "Word-cases turn the current word into title case" })
map("i", "<c-u>", "<esc>viw~ea", { desc = "Word-cases Toggle the current word into upper case" })

-- NOTE: Paste without overwriting register
map("v", "p", '"_dP')

-- NOTE: Paste last thing yanked, not deleted
map("n", "yp", '"0p')
map("n", "yP", '"0P')

-- NOTE: Change text without overwriting register
map({ "n", "v" }, "x", '"_x')

-- NOTE: Search for highlighted text in buffer
map("v", "//", 'y/<C-R>"<CR>', { desc = "Search for highlighted text" })

-- NOTE: Copy file paths
map("n", "<leader>cf", '<cmd>let @+ = expand("%")<CR>', { desc = "Copy File Name" })
map("n", "<leader>cp", '<cmd>let @+ = expand("%:p")<CR>', { desc = "Copy File Path" })

-- NOTE: Fix lsp bug with macro mode
map("n", "q", "", { desc = "Remove q to go macro mode" })
map("n", "Q", "q", { desc = "Mapping macro mode to Q" })

-- NOTE: Save file without auto-formatting
map("n", "<leader>sn", "<cmd>noautocmd w <CR>", { desc = "Save file without auto-formatting" })

map(
  "n",
  "<leader>cd",
  ":lcd %:p:h<CR>:pwd<CR>",
  { desc = "Change current working directory locally and print cwd after that" }
)

-- NOTE: Toggle comment with ctrl+/
map("n", "<C-/>", "gcc", { desc = "toggle comment", remap = true })
map("v", "<C-/>", "gc", { desc = "toggle comment", remap = true })

-- NOTE: Select whole file
map("n", "<a-a>", "ggVG", { desc = "Select whole file" })

-- NOTE: Copy whole file
map("n", "<leader>ya", "<cmd>%y+<CR>", { desc = "Copy whole file" })

-- NOTE: LSP format
map("n", "<leader>ii", function()
  vim.lsp.buf.format { async = true }
end, { desc = "LSP formatting" })

-- NOTE: Close all buffers stuff
map("n", "<leader>Q", function()
  require("nvchad.tabufline").closeBufs_at_direction "left"
  require("nvchad.tabufline").closeBufs_at_direction "right"
end, { desc = "Close all other buffers" })

nomap("n", "<leader>x")
map("n", "<leader>q", "<C-W>q", { desc = "buffer close" })

-- NOTE: Reselect the text that has just been pasted
map("n", "<leader>V", "`[V`]", { desc = "Reselect the text that has just been pasted" })

-- NOTE: Resize split windows with arrows
map("n", "<A-Up>", "<C-W>+", { desc = "Resize Horizontal Split Down" })
map("n", "<A-Down>", "<C-W>-", { desc = "Resize Horizontal Split Up" })
map("n", "<A-Right>", "<C-W>>", { desc = "Resize Vertical Split Down" })
map("n", "<A-Left>", "<C-W><", { desc = "Resize Vertical Split Up" })

-- NOTE: Split windows keymaps
map("n", "<leader>sv", "<C-W>v", { desc = "Split window vertically" })
map("n", "<leader>sh", "<C-W>s", { desc = "Split window horizontally" })
map("n", "<leader>sx", "<C-W>q", { desc = "Close split windows" })
map("n", "<leader>se", "<C-W>=", { desc = "Make split windows equal width & height" })
map("n", "<leader>sm", "<C-W>_ | <C-W>|", { desc = "Maximize window width & heigth" })
map("n", "<leader>s=", "<C-W>=", { desc = "Make split windows equal width & height" })

-- NOTE: Tabs
map("n", "<leader>tn", "<cmd> tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tx", "<cmd> tabclose<CR>", { desc = "Close current tab" }) --
map("n", "<leader>tk", "<cmd> tabn<CR>", { desc = "Go to next tab" }) --
map("n", "<leader>tj", "<cmd> tabp<CR>", { desc = "Go to previous tab" }) --

-- NOTE: Set tmux-navigator keymaps -> Make compatible Nvim with Tmux
map("n", "<C-h>", "<cmd> NvimTmuxNavigateLeft <CR>", { desc = "Window left" })
map("n", "<C-j>", "<cmd> NvimTmuxNavigateDown <CR>", { desc = "Window down" })
map("n", "<C-k>", "<cmd> NvimTmuxNavigateUp <CR>", { desc = "Window up" })
map("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", { desc = "Window right" })
map("n", "<C-\\>", "<Cmd>NvimTmuxNavigateLastActive<CR>", { desc = "Window up" })

-- NOTE: Navigate between buffers with ctrl + alt + j/k
map("n", "<A-C-K>", function()
  require("nvchad.tabufline").next()
end, { desc = "Buffer - goto next" })
map("n", "<A-C-J>", function()
  require("nvchad.tabufline").prev()
end, { desc = "Buffer - goto prev" })

-- NOTE: Enter new line in normal mode
map("n", "<leader>o", "o<ESC>", { desc = "New-line below" })
map("n", "<leader>O", "O<ESC>", { desc = "New-line top" })

-- NOTE: Indent with just one > and < in normal mode
map("n", "<", "<<", { desc = "Indent backward" })
map("n", ">", ">>", { desc = "Indent forward" })
map("v", ">", ">gv", { desc = "Being in visual mode when indent to right" })
map("v", "<", "<gv", { desc = "Being in visual mode when indent to right" })

-- NOTE: Go to start and end of the line with shift + H/L in normal and visual mode
map({ "n", "v" }, "H", "^", { desc = "Go to the first char at line" })
map({ "n", "v" }, "L", "$", { desc = "Go to the last char at line" })

-- NOTE: Aliases for exit from normal mode
map("i", "jk", "<ESC>", { desc = "escape insert mode", nowait = true })
map("i", "jj", "<ESC>", { desc = "escape insert mode", nowait = true })
map("i", "kk", "<ESC>", { desc = "escape insert mode", nowait = true })

-- NOTE: Add ctrl + v as paste in insert mode
map("i", "<M-C-V>", "<C-v>", { desc = "Map c-v to alt + ctrl + v" })
map("i", "<C-v>", "<ESC>pa", { desc = "Paste after cursor" })

-- NOTE: Copy current line with ctrl + c in normal and insert and visual mode
map("i", "<C-c>", "<CMD>yank<CR>", { desc = "Copy current line" })
map({ "n", "v" }, "<C-c>", ":yank<CR>", { desc = "Copy current line" })

-- NOTE: Cut line in insert mode
map("i", "<C-x>", "<esc>0Da")

-- NOTE: Save file with ctrl + s
map({ "n", "i", "v" }, "<C-s>", "<CMD>w<CR>", { desc = "Save file" })

-- NOTE: Undo with ctrl + z
map({ "i", "n", "v" }, "<C-z>", "<cmd>undo<cr>", { desc = "Undo" })
map({ "i", "n", "v" }, "<M-C-Z>", "<cmd>redo<cr>", { desc = "Redo" })

-- NOTE: Delete word after cursor in insert mode
map("i", "<C-Del>", "<ESC>ldwha", { desc = "Delete word after cursor" })

-- NOTE: Toggle NvimTree
nomap("n", "<leader>e")
map("n", "<leader>e", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle NvimTree" })

-- NOTE: Todos
nomap("n", "<leader>h")

map("n", "]t", function()
  require("todo-comments").jump_next { keywords = { "TODO", "FIX", "FIXME", "BUG", "FIXIT", "ISSUE" } }
end, { desc = "Next todo comment" })
map("n", "[t", function()
  require("todo-comments").jump_prev { keywords = { "TODO", "FIX", "FIXME", "BUG", "FIXIT", "ISSUE" } }
end, { desc = "Previous todo comment" })
map("n", "<leader>td", "<cmd> TodoTelescope keywords=TODO,FIX,FIXME,BUG,FIXIT,ISSUE <cr>", { desc = "[L]ist of todos" })

-- NOTE: UFO(pkg) folding:
map("n", "zR", require("ufo").openAllFolds, { desc = "UFO Open all folds" })
map("n", "zM", require("ufo").closeAllFolds, { desc = "UFO Close all folds" })
map("n", "zk", function()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then
    -- vim.lsp.buf.hover()
    require("lspsaga.hover"):render_hover_doc()
  end
end, { desc = "Show fold preview else show hover documentation" })

-- NOTE: Telescope
map("n", "<leader>mm", "<cmd>Telescope marks<CR>", { desc = "See all marks" })
map("n", "<leader>dd", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnostics" })
map("n", "<leader>rr", ":Telescope registers<CR>", { desc = "Registers in telescope" })
map("n", "<leader>tt", "<cmd>Telescope builtin<CR>", { desc = "[S]earch [S]elect Telescope" })
map({ "n", "v" }, "<leader>gr", "<cmd>Telescope lsp_references<CR>", { desc = "LSP Telescope show refrences" })
map({ "n", "v" }, "<leader>gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "LSP implementation" })
map({ "n", "v" }, "<leader>gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "LSP definition type" })

-- NOTE: LspSaga
map({ "n", "v" }, "gd", "<cmd>Lspsaga peek_definition<CR>", { desc = "LSP definition" })
map({ "n", "v" }, "gr", "<cmd>Lspsaga finder ref<CR>", { desc = "LSP Lspsaga show refrences" })
map({ "n", "v" }, "gi", "<cmd>Lspsaga finder imp<CR>", { desc = "LSP Lspsaga implementation" })
map({ "n", "v" }, "gt", "<cmd>Lspsaga finder tyd<CR>", { desc = "LSP Lspsaga definition type" })
map({ "n", "v" }, "gf", "<cmd>Lspsaga finder<CR>", { desc = "Show definition, references" })
map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Jump to next diagnostic in buffer" })
map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Jump to prev diagnostic in buffer" })
map({ "n", "v" }, "<leader>ra", "<cmd>Lspsaga rename<CR>", { desc = "Smart rename" })
map({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "See available code actions" })
map({ "n", "v" }, "<leader>K", "<cmd>Lspsaga hover_doc<CR>", { desc = "See hover doc" })
map("n", "K", function()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line "." - 1 })
  if #diagnostics > 0 then
    require("lspsaga.diagnostic.show"):show_diagnostics { line = true }
  else
    local winid = require("ufo").peekFoldedLinesUnderCursor()
    if not winid then
      -- vim.lsp.buf.hover()
      require("lspsaga.hover"):render_hover_doc()
    end
  end
end, { desc = "Show errors if exist, else show fold preview, else Show documentation for what is under cursor" })

-- NOTE: Gitsigns
local gitsigns = require "gitsigns"

-- Navigation
map("n", "]c", function()
  if vim.wo.diff then
    vim.cmd.normal { "]c", bang = true }
  else
    gitsigns.nav_hunk "next"
  end
end)

map("n", "[c", function()
  if vim.wo.diff then
    vim.cmd.normal { "[c", bang = true }
  else
    gitsigns.nav_hunk "prev"
  end
end)

-- Actions
map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "[S]tage Hunk" })
map("v", "<leader>hs", function()
  gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { desc = "[S]tage Hunk" })

map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "[R]eset Hunk" })

map("v", "<leader>hr", function()
  gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { desc = "[R]eset Hunk" })

map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "[S]tage Buffer" })
map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "[R]eset Buffer" })
map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "[P]review Hunk" })
map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "[P]review Hunk Inline" })

map("n", "<leader>hb", function()
  gitsigns.blame_line { full = true }
end, {
  desc = "[B]lame line",
})

map("n", "<leader>hd", gitsigns.diffthis, {
  desc = "[D]iff this",
})

map("n", "<leader>hD", function()
  gitsigns.diffthis "~"
end, {
  desc = "[D]iff this",
})

map("n", "<leader>hQ", function()
  gitsigns.setqflist "all"
end, {
  desc = "[S]etqflist all",
})
map("n", "<leader>hq", gitsigns.setqflist, {
  desc = "[S]etqflist",
})

-- Toggles
map("n", "<leader>tb", gitsigns.toggle_current_line_blame, {
  desc = "[T]oggle current line blame",
})
map("n", "<leader>tw", gitsigns.toggle_word_diff, {
  desc = "[T]oggle word diff",
})

-- Text object
map({ "o", "x" }, "ih", gitsigns.select_hunk, {
  desc = "[S]elect Hunk",
})

-- NOTE:  Multicursor
local mc = require "multicursor-nvim"
map({ "n", "x" }, "<C-up>", function()
  mc.lineAddCursor(-1)
end)
map({ "n", "x" }, "<C-down>", function()
  mc.lineAddCursor(1)
end)
map({ "n", "x" }, "<leader>k", function()
  mc.lineSkipCursor(-1)
end)
map({ "n", "x" }, "<leader>j", function()
  mc.lineSkipCursor(1)
end)

-- Add or skip adding a new cursor by matching word/selection
nomap("n", "<C-n>")
map({ "n", "x" }, "<C-n>", function()
  mc.matchAddCursor(1)
end)
map({ "n", "x" }, "<C-S-n>", function()
  mc.matchAddCursor(-1)
end)
map({ "n", "x" }, "<leader>s", function()
  mc.matchSkipCursor(1)
end)
map({ "n", "x" }, "<leader>S", function()
  mc.matchSkipCursor(-1)
end)
-- Add and remove cursors with control + left click.
map("n", "<c-leftmouse>", mc.handleMouse)
map("n", "<c-leftdrag>", mc.handleMouseDrag)
map("n", "<c-leftrelease>", mc.handleMouseRelease)
-- Disable and enable cursors.
map({ "n", "x" }, "<c-q>", mc.toggleCursor)

-- NOTE: Opencode
map({ "n", "x" }, "<leader>ai", function()
  require("opencode").ask("@this: ", { submit = true })
end, { desc = "Ask opencode" })
map({ "n", "x" }, "<leader>ax", function()
  require("opencode").select()
end, { desc = "Execute opencode action…" })
map({ "n", "x" }, "<leader>ar", function()
  return require("opencode").operator "@this "
end, { expr = true, desc = "Add range to opencode" })
map("n", "<leader>al", function()
  return require("opencode").operator "@this " .. "_"
end, { expr = true, desc = "Add line to opencode" })
map("n", "<S-C-u>", function()
  require("opencode").command "session.half.page.up"
end, { desc = "opencode half page up" })
map("n", "<S-C-d>", function()
  require("opencode").command "session.half.page.down"
end, { desc = "opencode half page down" })

-- NOTE: Luasnip
local ls = require "luasnip"
map({ "i", "s" }, "<A-k>", function()
  ls.jump(1)
end, { silent = true })
map({ "i", "s" }, "<A-j>", function()
  ls.jump(-1)
end, { silent = true })

-- NOTE: Inlay hint
map("n", "<leader>hh", function()
  local currentState = vim.lsp.inlay_hint.is_enabled()
  vim.lsp.inlay_hint.enable(not currentState)
  if currentState then
    vim.notify("Inlay hint is disabled", vim.log.levels.INFO)
  else
    vim.notify("Inlay hint is enabled", vim.log.levels.INFO)
  end
end, { desc = "Toggle inlay hint" })
