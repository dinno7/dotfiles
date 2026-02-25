-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@class ChadrcConfig
local M = {}

M.base46 = {
  theme = "tokyonight",
  transparency = true,

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
    icons = true,
    icons_left = false, -- only for non-atom styles!
    lspkind_text = true,
    style = "atom", -- default/flat_light/flat_dark/atom/atom_colored
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
    order = { "mode", "full_path", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cursor", "cwd" },
    modules = {
      full_path = function()
        local x = require("nvchad.stl.utils").file()
        local icon = x[1]
        local file_name = x[2]
        local cwd = vim.uv.cwd()
        local home = vim.fn.expand "$HOME"
        local path_without_home = cwd:gsub("^" .. home, "~")
        local full_path = "%#StText#" .. "  " .. path_without_home
        if file_name ~= "Empty" then
          full_path = full_path .. " " .. icon .. " " .. file_name
        end
        return full_path
      end,
    },
  },

  -- lazyload it when there are 1+ buffers
  tabufline = {
    enabled = true,
    lazyload = true,
    order = { "treeOffset", "buffers", "tabs", "btns" },
    modules = nil,
    show_numbers = true,
    buffer_id_index = true,
    bufwidth = 30,
    icon_colors = true,
  },
}

M.term = {
  winopts = { number = false, relativenumber = false },
  sizes = { sp = 0.3, vsp = 0.3, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
  float = {
    relative = "editor",
    row = 0.02,
    col = 0.02,
    width = 0.95,
    height = 0.95,
    border = "single",
  },
}

M.mason = {
  pkgs = {
    "dockerfile-language-server",
    "docker-compose-language-service",
    "bash-language-server",
    "cspell-lsp",
    "css-lsp",
    "docker-language-server",
    "emmet-ls",
    "eslint-lsp",
    "html-lsp",
    "json-lsp",
    "just-lsp",
    "lua-language-server",
    "postgres-language-server",
    "prettierd",
    "rust-analyzer",
    "shellcheck",
    "shfmt",
    "sql-formatter",
    "stylua",
    "tailwindcss-language-server",
    "typescript-language-server",
    "yaml-language-server",

    -- > GO lang
    "gopls",
    "gofumpt",
    "goimports",
    "golangci-lint",
    "golines",
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
    -- [[               Powered By  eovim                ]],
    [[                  I use 󰣇 BTW                     ]],
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
