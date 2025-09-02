return {
  "nvim-mini/mini.move",
  event = "VeryLazy",
  version = false,
  config = function()
    require("mini.move").setup()
  end,
}
