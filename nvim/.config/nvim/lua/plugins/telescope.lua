return {
  "nvim-telescope/telescope.nvim",
  -- NOTE: `opts` must be a function, otherwise `require("telescope.actions")` runs while
  -- the specs are parsed and force-loads telescope (+ treesitter) on every startup.
  -- It receives the already merged NvChad opts and deep-extends them, same as a plain table would.
  opts = function(_, opts)
    local actions = require "telescope.actions"
    return vim.tbl_deep_extend("force", opts, {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<Esc>"] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        oldfiles = {
          cwd_only = true,
        },
      },
    })
  end,
}
