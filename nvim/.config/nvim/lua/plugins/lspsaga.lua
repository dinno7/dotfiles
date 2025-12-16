return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  config = function()
    require("lspsaga").setup {
      -- keybinds for navigation in lspsaga window
      scroll_preview = { scroll_down = "<C-d>", scroll_up = "<C-u>" },
      lightbulb = { sign = true },
      -- use enter to open file with definition preview
      definition = {
        width = 0.8,
        height = 0.6,
      },
      finder = {
        max_height = 0.8,
        default = "ref+def+imp+tyd", -- def -> textDocument/definition, ref -> textDocument/references, and imp -> textDocuemnt/implementation
        left_width = 0.2,
        right_width = 0.8,
        layout = "float", -- float, normal
        methods = {
          tyd = "textDocument/typeDefinition",
        },
        keys = {
          toggle_or_open = { "<CR>", "o" },
          vsplit = "v", -- open in vsplit
          split = "x", -- open in split
          shuttle = { "<Tab>" },
        },
      },
      diagnostic = {
        show_code_action = true,
        max_width = 0.8,
        max_height = 1,
      },
      callhierarchy = {
        keys = {
          toggle_or_open = { "<CR>", "o" },
          vsplit = "v", -- open in vsplit
          split = "x", -- open in split
          shuttle = { "<Tab>" },
        },
      },
      ui = {
        colors = {
          normal_bg = "#022746",
        },
      },
    }
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons", -- optional
  },
}
