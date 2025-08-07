local keys = {
  toggle_or_open = { "<Tab>", "<CR>" },
  vsplit = "v", -- open in vsplit
  split = "x", -- open in split
  -- shuttle = { "l", "h" },
}
return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  config = function()
    require("lspsaga").setup {
      -- keybinds for navigation in lspsaga window
      scroll_preview = { scroll_down = "<C-d>", scroll_up = "<C-u>" },
      lightbulb = { sign = false },
      -- use enter to open file with definition preview
      definition = {
        edit = "<CR>",
      },
      finder = {
        keys = keys,
      },
      callhierarchy = {
        keys = keys,
      },
      ui = {
        colors = {
          normal_bg = "#022746",
        },
        code_action = "💀",
      },
    }
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons", -- optional
  },
}
