return {
  "lewis6991/gitsigns.nvim",
  config = function()
    local defualtConfigs = require "nvchad.configs.gitsigns"
    local opts = vim.tbl_deep_extend("force", defualtConfigs, {
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
      },
      current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
    })

    require("gitsigns").setup(opts)
  end,
}
