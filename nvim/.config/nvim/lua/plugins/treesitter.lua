return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  branch = "main",
  opts = function()
    local opts = require "nvchad.configs.treesitter"
    opts.auto_install = true
    -- A list of parser names, or "all"
    -- Install parsers synchronously (only applied to `ensure_installed`)
    opts.sync_install = false
    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
    opts.auto_install = true
    opts.indent = {
      enable = true,
    }
    opts.highlight = {
      -- `false` will disable the whole extension
      enable = true,
      disable = function(lang, buf)
        if lang == "html" then
          print "disabled"
          return true
        end

        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          vim.notify(
            "File larger than 100KB treesitter disabled for performance",
            vim.log.levels.WARN,
            { title = "Treesitter" }
          )
          return true
        end
      end,
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = { "markdown" },
    }
    opts.ensure_installed = {
      "go",
      "lua",
      "sql",
      "vim",
      "tsx",
      "css",
      "html",
      "rust",
      "bash",
      "zsh",
      "csv",
      "proto",
      "json",
      "toml",
      "yaml",
      "just",
      "tmux",
      "json5",
      "regex",
      "vimdoc",
      "markdown",
      "desktop",
      "devicetree",
      "gitcommit",
      "gitignore",
      "git_rebase",
      "git_config",
      "dockerfile",
      "typescript",
      "javascript",
    }
    return opts
  end,
}
