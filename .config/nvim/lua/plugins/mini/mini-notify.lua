return {
  "nvim-mini/mini.notify",
  lazy = false,
  version = false,
  config = function()
    local notify = require "mini.notify"
    notify.setup()
    vim.notify = notify.make_notify {
      ERROR = { duration = 5000 },
      WARN = { duration = 4000 },
      INFO = { duration = 3000 },
      DEBUG = { duration = 5000 },
      TRACE = { duration = 1000 },
      OFF = { duration = 1000 },
    }
  end,
}
