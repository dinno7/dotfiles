-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@class ChadrcConfig
local M = {}

M.base46 = {
  theme = "nightlamp",
  transparency = false,

  hl_add = {
    ["HLOnYank"] = { bg = "#a6e3a1", fg = "#303446" },
  },
  hl_override = {
    ["@comment"] = { fg = "#9399b2" },
    CursorLine = {
      bg = "#24273a",
    },
    Folded = {
      bg = "#363a4f",
    },
    Visual = {
      bg = "#586985",
      fg = "#f7faff",
    },
  },
}

M.ui = {
  cmp = {
    icons_left = false, -- only for non-atom styles!
    lspkind_text = true,
    style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
    format_colors = {
      tailwind = true, -- will work for css lsp too
      icon = "󱓻",
    },
  },

  telescope = { style = "bordered" }, -- borderless / bordered
  statusline = {
    enabled = true,
    theme = "vscode_colored", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "default",
    order = nil,
    modules = nil,
  },

  -- lazyload it when there are 1+ buffers
  tabufline = {
    enabled = true,
    lazyload = true,
    order = { "treeOffset", "buffers", "tabs", "btns" },
    modules = nil,
    show_numbers = true,
    buffer_id_index = true,
    icon_colors = true,
  },
}

M.term = {
  winopts = { number = false, relativenumber = false },
  sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
  float = {
    relative = "editor",
    row = 0.3,
    col = 0.25,
    width = 0.5,
    height = 0.5,
    border = "single",
  },
}

-- Highlight colors in Neovim
M.colorify = {
  enabled = true,
  mode = "virtual", -- fg, bg, virtual
  virt_text = "󱓻 ",
  highlight = { hex = true, lspvars = true },
}

M.nvdash = {
  load_on_startup = true,
  header = {
    [[ ██████████    ███                                ]],
    [[░░███░░░░███  ░░░                                 ]],
    [[ ░███   ░░███ ████  ████████   ████████    ██████ ]],
    [[ ░███    ░███░░███ ░░███░░███ ░░███░░███  ███░░███]],
    [[ ░███    ░███ ░███  ░███ ░███  ░███ ░███ ░███ ░███]],
    [[ ░███    ███  ░███  ░███ ░███  ░███ ░███ ░███ ░███]],
    [[ ██████████   █████ ████ █████ ████ █████░░██████ ]],
    [[░░░░░░░░░░   ░░░░░ ░░░░ ░░░░░ ░░░░ ░░░░░  ░░░░░░  ]],
    [[                                                  ]],
    [[                                                  ]],
    [[                                                  ]],
    [[    █████                                █████    ]],
    [[   ░░███                                ░░███     ]],
    [[    ░███         ██████   ████████    ███████     ]],
    [[    ░███        ░░░░░███ ░░███░░███  ███░░███     ]],
    [[    ░███         ███████  ░███ ░███ ░███ ░███     ]],
    [[    ░███      █ ███░░███  ░███ ░███ ░███ ░███     ]],
    [[    ███████████░░████████ ████ █████░░████████    ]],
    [[   ░░░░░░░░░░░  ░░░░░░░░ ░░░░ ░░░░░  ░░░░░░░░     ]],
    [[                                                  ]],
    [[               Powered By  eovim                ]],
    [[                                                  ]],

    -- [[                                                                       ]],
    -- [[                                                                       ]],
    -- [[                                                                       ]],
    -- [[                                                                       ]],
    -- [[                                                                     ]],
    -- [[       ████ ██████           █████      ██                     ]],
    -- [[      ███████████             █████                             ]],
    -- [[      █████████ ███████████████████ ███   ███████████   ]],
    -- [[     █████████  ███    █████████████ █████ ██████████████   ]],
    -- [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
    -- [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
    -- [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
    -- [[                                                                       ]],
    -- [[                                                                       ]],
    -- [[                                                                       ]],
  },

  buttons = {
    { txt = "  Recent Files", keys = "Spc f o", cmd = "Telescope oldfiles" },
    { txt = "  Find File", keys = "Spc f f", cmd = "Telescope find_files" },
    { txt = "  Find Word", keys = "Spc f w", cmd = "Telescope live_grep" },
    { txt = "  Bookmarks", keys = "Spc m a", cmd = "Telescope marks" },
    { txt = "  Themes", keys = "Spc t h", cmd = "Telescope themes" },
    { txt = "  Mappings", keys = "Spc c h", cmd = "NvCheatsheet" },
    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashLazy",
      no_gap = true,
    },

    { txt = "─", hl = "NvDashLazy", no_gap = true, rep = true },
  },
}
return M
