return {
  "phaazon/hop.nvim",
  lazy = false,
  config = function()
    require("hop").setup {
      keys = "etovxqpdygfblzhckisuran",
    }
    -- place this in one of your configuration file(s)
    -- local directions = require("hop.hint").HintDirection
    --vim.keymap.set("", "F", function()
    --   hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = false }
    -- end, { remap = true })
    -- vim.keymap.set("", "t", function()
    --   hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 }
    -- end, { remap = true })
    -- vim.keymap.set("", "T", function()
    --   hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 }
    -- end, { remap = true })

    vim.api.nvim_create_user_command("HopChar2ACHO1", function()
      pcall(function()
        require("hop").hint_char2 { direction = require("hop.hint").HintDirection.AFTER_CURSOR, hint_offset = 2 }
      end)
    end, {})

    vim.api.nvim_create_user_command("HopChar2BCHO1", function()
      pcall(function()
        require("hop").hint_char2 { direction = require("hop.hint").HintDirection.BEFORE_CURSOR, hint_offset = 2 }
      end)
    end, {})
  end,
}
