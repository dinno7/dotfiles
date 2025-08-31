return {
  "nvim-mini/mini.notify",
  lazy = false,
  version = false,
  config = function()
    require("mini.notify").setup()
  end,
}
