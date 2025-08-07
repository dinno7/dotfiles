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
map("n", "<Tab>", "%", { desc = "Jump to matching pair easily in normal mode" })

-- NOTE: Word cases
map("i", "<c-t>", "<esc>b~lea", { desc = "Word-cases Turn the current word into title case" })
map("i", "<c-u>", "<esc>viw~ea", { desc = "Word-cases Toggle the current word into upper case" })

-- NOTE: Paste without overwriting register
map("v", "p", '"_dP')

-- NOTE: Change text without overwriting register
map({ "n", "v" }, "x", '"_x')

-- NOTE: Move block
-- map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move Block Up" })
-- map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move Block Down" })

-- NOTE: Move line
-- map("i", "<A-j>", "<ESC>V:m '>+1<CR>a", { desc = "Move line down" })
-- map("i", "<A-k>", "<ESC>V:m '<-2<CR>a", { desc = "Move line up" })
-- map("n", "<A-j>", "V:m '>+1<CR>", { desc = "Move line down" })
-- map("n", "<A-k>", "V:m '<-2<CR>", { desc = "Move line up" })

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

-- NOTE: Close all other buffers
map("n", "<leader>X", function()
  require("nvchad.tabufline").closeBufs_at_direction "left"
  require("nvchad.tabufline").closeBufs_at_direction "right"
end)

-- NOTE: Select whole file
map("n", "<leader>a", "ggVG", { desc = "Select whole file" })

-- NOTE: Copy whole file
map("n", "<leader>ya", "<cmd>%y+<CR>", { desc = "Copy whole file" })

-- NOTE: LSP format
map("n", "<leader>ii", function()
  vim.lsp.buf.format { async = true }
end, { desc = "LSP formatting" })

-- NOTE: Close all files(exit neovim)
map("n", "<leader>Q", ":qa<CR>", { desc = "Close all buffers" })
map("n", "<leader>q", ":x<CR>", { desc = "Save the file if modified and exit" })

-- NOTE: Reselect the text that has just been pasted
map("n", "<leader>V", "`[V`]", { desc = "Reselect the text that has just been pasted" })

-- NOTE: Resize split windows with arrows
map("n", "<A-Up>", ":resize +5<CR>", { desc = "Resize Horizontal Split Down" })
map("n", "<A-Down>", ":resize -5<CR>", { desc = "Resize Horizontal Split Up" })
map("n", "<A-Right>", ":vertical resize -5<CR>", { desc = "Resize Vertical Split Down" })
map("n", "<A-Left>", ":vertical resize +5<CR>", { desc = "Resize Vertical Split Up" })

-- NOTE: Split windows keymaps
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>ss", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Make split windows equal width & height" })
map("n", "<leader>sx", "<cmd> close <CR>", { desc = "Close split windows" })

-- NOTE: Tabs
map("n", "<leader>tn", "<cmd> tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tx", "<cmd> tabclose<CR>", { desc = "Close current tab" }) --
map("n", "<leader>tk", "<cmd> tabn<CR>", { desc = "Go to next tab" }) --
map("n", "<leader>tj", "<cmd> tabp<CR>", { desc = "Go to previous tab" }) --
map("n", "<A-C-l>", "<cmd> tabn<CR>", { desc = "Go to next tab" }) --
map("n", "<A-C-h>", "<cmd> tabp<CR>", { desc = "Go to previous tab" }) --

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

-- NOTE: hop easymotion:
map("n", "<leader><leader>s", "<cmd> HopChar1MW <CR>", { desc = "Search by 1 characters" })
map("n", "<leader><leader>S", "<cmd> HopChar2MW <CR>", { desc = "Search by 2 characters" })
map("n", "<leader><leader>f", "<cmd> HopChar1AC <CR>", { desc = "Find 1 characters forwards" })
map("n", "<leader><leader>F", "<cmd> HopChar1BC <CR>", { desc = "Find 1 characters backwards" })
map("n", "<leader><leader>t", "<cmd> HopChar2ACHO1 <CR>", { desc = "Til 2 characters forwards" })
map("n", "<leader><leader>T", "<cmd> HopChar2BCHO1 <CR>", { desc = "Til 2 characters backwards" })
map("n", "<leader><leader>j", "<cmd> HopLineStartAC <CR>", { desc = "Start of lines forwards" })
map("n", "<leader><leader>k", "<cmd> HopLineStartBC <CR>", { desc = "Start of lines backwards" })
map("n", "<leader><leader>w", "<cmd> HopWordMW <CR>", { desc = "Start of words" })
map("n", "<leader><leader>/", "<cmd> HopPatternMW <CR>", { desc = "Search by pattern" })

-- NOTE: Telescope
map("n", "<leader>gr", "<cmd>Telescope lsp_references<CR>", { desc = "LSP Telescope show refrences" })
map("n", "<leader>mm", "<cmd>Telescope marks<CR>", { desc = "See all marks" })
map("n", "<leader>dd", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnostics" })
map("n", "<leader>rr", ":Telescope registers<CR>", { desc = "Registers in telescope" })
map("n", "<leader>tt", "<cmd>Telescope builtin<CR>", { desc = "[S]earch [S]elect Telescope" })
map("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "LSP Telescope show refrences" })
map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "LSP implementation" })
map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "LSP definition type" })

-- NOTE: LspSaga
map("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { desc = "LSP definition" })
map("n", "gf", "<cmd>Lspsaga finder<CR>", { desc = "Show definition, references" })
map("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "Show line diagnostics" })
map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Jump to next diagnostic in buffer" })
map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Jump to prev diagnostic in buffer" })
map("n", "<leader>ra", "<cmd>Lspsaga rename<CR>", { desc = "Smart rename" })
map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "See available code actions" })
map("n", "<leader>k", "<cmd>Lspsaga hover_doc<CR>", { desc = "See hover doc" })
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
