return {
  "nvim-mini/mini.trailspace",
  event = "VeryLazy",
  version = false,
  config = function()
    require("mini.trailspace").setup {
      only_in_normal_buffers = true,
    }
  end,
}
