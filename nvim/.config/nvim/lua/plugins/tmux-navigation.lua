return {
  "alexghergh/nvim-tmux-navigation",
  event = "VeryLazy",
  config = function()
    require("nvim-tmux-navigation").setup {
      disable_when_zoomed = false, -- defaults to false
    }
  end,
}
