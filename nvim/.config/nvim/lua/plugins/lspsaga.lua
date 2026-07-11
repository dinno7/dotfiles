return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  config = function()
    require("lspsaga").setup {
      -- keybinds for navigation in lspsaga window
      -- scroll_preview = { scroll_down = "<c-d>", scroll_up = "<c-u>" },
      lightbulb = { sign = true },
      -- use enter to open file with definition preview
      definition = {
        width = 0.8,
        height = 0.6,
      },
      hover_doc = {
        max_width = 1,
        max_height = 1,
      },
      finder = {
        -- max_height = 0.8,
        -- left_width = 0.2,
        -- right_width = 0.8,
        -- layout = "float", -- float, normal
        max_height = 1,
        left_width = 0.5,
        right_width = 0.5,
        layout = "normal", -- float, normal
        default = "def+imp+ref+tyd", -- def -> textDocument/definition, ref -> textDocument/references, and imp -> textDocuemnt/implementation
        methods = {
          tyd = "textDocument/typeDefinition",
        },
        keys = {
          toggle_or_open = { "<CR>", "o" },
          shuttle = "[w",
          vsplit = "v", -- open in vsplit
          split = "x", -- open in split
        },
      },
      rename = {
        in_select = false,
        auto_save = true,
        project_max_width = 0.5,
        project_max_height = 0.5,
        keys = {
          quit = { "q", "<ESC>" },
          exec = "<CR>",
          select = "space",
        },
      },
      code_action = {
        -- num_shortcut = true,
        -- show_server_name = false,
        -- extend_gitsigns = true,
        num_shortcut = true, -- whether number shortcut for code actions are enabled
        show_server_name = true, -- show language server name
        extend_gitsigns = true, -- extend gitsigns plugin diff action
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
        layout = "float", -- normal, float
        keys = {
          toggle_or_open = { "<CR>", "o" },
          vsplit = "v", -- open in vsplit
          split = "x", -- open in split
        },
      },
      -- ui = {
      -- colors = {
      --   normal_bg = "#022746",
      -- },
      -- },
      symbol_in_winbar = {
        enable = true,
        color_mode = true,
        separator = " › ",
      },
    }
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons", -- optional
  },
}
