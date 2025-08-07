return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "vim",
      "lua",
      "vimdoc",
      "html",
      "css",
      "go",
      "bash",
    },
    incremental_selection = {
      keymaps = {
        -- mappings for incremental selection (visual mappings)
        init_selection = "qqq", -- maps in normal mode to init the node/scope selection
        node_incremental = "qqqq", -- increment to the upper named parent
        scope_incremental = "qqqqq", -- increment to the upper scope (as defined in locals.scm)
        node_decremental = "qqqqqqq", -- decrement to the previous node
      },
    },
  },
}
