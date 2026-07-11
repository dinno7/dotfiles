return {
  "lewis6991/gitsigns.nvim",
  config = function()
    local defualtConfigs = require "nvchad.configs.gitsigns"

    local opts = vim.tbl_deep_extend("force", defualtConfigs, {
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {

        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
      },
      current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
      numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
      preview_config = {
        -- Options passed to nvim_open_win
        border = "single", -- or 'rounded', 'solid'
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    })

    require("gitsigns").setup(opts)
  end,
}
