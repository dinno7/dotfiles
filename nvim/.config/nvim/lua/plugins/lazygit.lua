return {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = {
    { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  },
  config = function()
    vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
    vim.g.lazygit_floating_window_scaling_factor = 1 -- scaling factor for floating window
    -- vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } -- customize lazygit popup window border characters
    vim.g.lazygit_floating_window_border_chars = { "", "", "", "", "", "", "", "" } -- customize lazygit popup window border characters
    vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
    vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed
    vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
    vim.g.lazygit_config_file_path = "~/.config/lazygit/config.yml" -- custom config file path
    -- OR
    -- vim.g.lazygit_config_file_path = {} -- table of custom config file paths
    vim.g.lazygit_on_exit_callback = nil -- optional function callback when exiting lazygit (useful for example to refresh some UI elements after lazy git has made some changes)

    -- Pass navigation keys directly to lazygit
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "*lazygit*",
      callback = function()
        -- Create buffer-local mappings that override the global tmux navigation
        -- By mapping the keys to themselves, Neovim sends them directly to the terminal
        local opts = { buffer = true, nowait = true }
        vim.keymap.set("t", "<C-h>", "<C-h>", opts)
        vim.keymap.set("t", "<C-j>", "<C-j>", opts)
        vim.keymap.set("t", "<C-k>", "<C-k>", opts)
        vim.keymap.set("t", "<C-l>", "<C-l>", opts)
      end,
    })

    vim.keymap.set("t", "<C-A-c>", function()
      vim.api.nvim_win_close(vim.api.nvim_get_current_win(), true)
      vim.notify "hi"

      -- just for lazygit
      -- vim.schedule(function()
      --   vim.api.nvim_command "LazyGit"
      -- end)
    end, { desc = "AI Commit Msg" })
  end,
}
