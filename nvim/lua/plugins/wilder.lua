return {
  {
    "gelguy/wilder.nvim",
    keys = {
      ":",
      "/",
      "?",
    },
    dependencies = {
      "catppuccin/nvim",
    },
    config = function()
      local wilder = require "wilder"
      local macchiato = require("catppuccin.palettes").get_palette "macchiato"

      -- Create a highlight group for the popup menu
      -- local mauve_highlight = wilder.make_hl("WilderMauve", { { a = 1 }, { a = 1 }, { foreground = macchiato.mauve } })
      -- local blue_highlight = wilder.make_hl("WilderMauve", { { a = 1 }, { a = 1 }, { foreground = macchiato.blue } })
      local text_highlight = wilder.make_hl("WilderText", { { a = 1 }, { a = 1 }, { foreground = macchiato.text } })
      local maroon_highlight =
        wilder.make_hl("WilderMaroon", { { a = 1 }, { a = 1 }, { foreground = macchiato.maroon } })
      local sapphire_highlight =
        wilder.make_hl("WilderSapphire", { { a = 1 }, { a = 1 }, { foreground = macchiato.sapphire } })

      -- Enable wilder when pressing :, / or ?
      wilder.setup { modes = { ":", "/", "?" } }

      wilder.set_option("pipeline", {
        wilder.branch(
          -- Enable fuzzy matching for commands and buffers
          wilder.cmdline_pipeline {
            fuzzy = 1,
          },
          wilder.vim_search_pipeline {
            fuzzy = 1,
          }
        ),
      })

      wilder.set_option(
        "renderer",
        wilder.popupmenu_renderer(wilder.popupmenu_palette_theme {
          highlighter = wilder.basic_highlighter(),
          highlights = {
            default = text_highlight,
            border = maroon_highlight,
            accent = sapphire_highlight,
          },
          -- 'single', 'double', 'rounded' or 'solid'
          -- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
          border = "rounded",
          max_width = "50%",
          min_width = "50%",
          max_height = "40%", -- max height of the palette
          min_height = 0, -- set to the same as 'max_height' for a fixed height window
          prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
          reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
          left = { " ", wilder.popupmenu_devicons() },
          right = { " ", wilder.popupmenu_scrollbar() },
        })
      )
    end,
  },
}
