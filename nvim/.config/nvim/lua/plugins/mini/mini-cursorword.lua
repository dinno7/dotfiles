return {
  "nvim-mini/mini.cursorword",
  event = "VeryLazy",
  version = false,
  config = function()
    require("mini.cursorword").setup()
  end,
}
