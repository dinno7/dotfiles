return {
  "nvim-mini/mini.animate",
  event = "VeryLazy",
  version = false,
  config = function()
    local animate = require "mini.animate"
    animate.setup {

      -- Cursor path
      cursor = {
        -- Whether to enable this animation
        enable = true,
        -- Timing of animation (how steps will progress in time)
        timing = animate.gen_timing.linear { duration = 150, unit = "total" },
      },
    }
  end,
}
