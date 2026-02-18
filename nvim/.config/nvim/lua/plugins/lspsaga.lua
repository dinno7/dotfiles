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
        },
      },
      rename = {
        in_select = true,
        auto_save = true,
        project_max_width = 0.5,
        project_max_height = 0.5,
        keys = {
          quit = { "q", "<ESC>" },
          exec = "<CR>",
          select = "x",
        },
      },
      code_action = {
        num_shortcut = 2,
        show_server_name = true,
        extend_gitsigns = true,
        keys = {
          quit = { "q", "<ESC>" },
          exec = "<CR>",
        },
      },
      diagnostic = {
        show_code_action = true,
        max_width = 0.8,
        max_height = 1,
      },
      underline = {
        -- Do not underline text when severity is low (INFO or HINT).
        severity = { min = vim.diagnostic.severity.WARN },
      },
      callhierarchy = {
        keys = {
          toggle_or_open = { "<CR>", "o" },
          vsplit = "v", -- open in vsplit
          split = "x", -- open in split
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
