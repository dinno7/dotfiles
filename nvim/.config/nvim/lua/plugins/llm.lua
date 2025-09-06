-- Write a fibo function in lua:
local function fibo() end

return {
  {
    "Kurama622/llm.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
    config = function()
      local tools = require "llm.tools" -- for app tools
      require("llm").setup {
        prompt = "You are a professional programmer.",
        prefix = {
          user = { text = "💀Dinno: ", hl = "Title" },
          assistant = { text = "  ", hl = "Added" },
        },
        history_path = "/tmp/llm-history",
        save_session = true,
        max_history = 15,
        max_history_name_length = 20,

        -- style2: set parameters of multiple models
        -- (If you need to use multiple models and frequently switch between them.)
        models = {
          {
            name = "Kimi k2",
            url = "https://openrouter.ai/api/v1/chat/completions",
            model = "moonshotai/kimi-k2:free",
            api_type = "openai",
            max_tokens = 4096,
            temperature = 0.3,
            top_p = 0.7,
            fetch_key = function()
              return vim.env.OPENROUTER_API_KEY
            end,
          },
          {
            name = "Qwen3 Coder",
            url = "https://openrouter.ai/api/v1/chat/completions",
            model = "qwen/qwen3-coder:free",
            api_type = "openai",
            max_tokens = 4096,
            temperature = 0.3,
            top_p = 0.7,
            fetch_key = function()
              return vim.env.OPENROUTER_API_KEY
            end,
          },
        },

        ---------------- set your keymaps for interaction ---------------
        keys = {
          -- The keyboard mapping for the input window.
          ["Input:Submit"] = { mode = "n", key = "<cr>" },
          ["Input:Cancel"] = { mode = { "n", "i" }, key = "<C-c>" },
          ["Input:Resend"] = { mode = { "n", "i" }, key = "<C-r>" },

          -- only works when "save_session = true"
          ["Input:HistoryNext"] = { mode = { "n", "i" }, key = "<C-j>" },
          ["Input:HistoryPrev"] = { mode = { "n", "i" }, key = "<C-k>" },

          -- For changing models
          ["Input:ModelsNext"] = { mode = { "n", "i" }, key = "<A-C-J>" },
          ["Input:ModelsPrev"] = { mode = { "n", "i" }, key = "<A-C-K>" },

          -- The keyboard mapping for the output window in "split" style.
          ["Output:Ask"] = { mode = "n", key = "i" },
          ["Output:Cancel"] = { mode = "n", key = "<C-c>" },
          ["Output:Resend"] = { mode = "n", key = "<C-r>" },

          -- The keyboard mapping for the output and input windows in "float" style.
          ["Session:Toggle"] = { mode = "n", key = "<leader>ac" },
          ["Session:Close"] = { mode = "n", key = { "<esc>", "Q" } },

          -- Scroll
          ["PageUp"] = { mode = { "i", "n" }, key = "<C-b>" },
          ["PageDown"] = { mode = { "i", "n" }, key = "<C-f>" },
          ["HalfPageUp"] = { mode = { "i", "n" }, key = "<C-u>" },
          ["HalfPageDown"] = { mode = { "i", "n" }, key = "<C-d>" },
          ["JumpToTop"] = { mode = "n", key = "gg" },
          ["JumpToBottom"] = { mode = "n", key = "G" },

          ---------------- set your tools for interaction ---------------
        },
        app_handler = {
          CommitMsg = {
            handler = tools.flexi_handler,
            prompt = function()
              -- Source: https://andrewian.dev/blog/ai-git-commits
              return string.format(
                [[%s:
```diff
%s
```
]],
                vim.env.AI_PROMPT_GIT_COMMIT,
                vim.fn.system "git diff --no-ext-diff --staged"
              )
            end,

            opts = {
              enter_flexible_window = true,
              apply_visual_selection = false,
              win_opts = {
                relative = "editor",
                position = "50%",
              },
              accept = {
                mapping = {
                  mode = "n",
                  keys = "<cr>",
                },
                action = function()
                  local contents = vim.api.nvim_buf_get_lines(0, 0, -1, true)

                  local cmd = string.format('!git commit -m "%s"', table.concat(contents, '" -m "'))
                  cmd = (cmd:gsub(".", {
                    ["#"] = "\\#",
                  }))

                  vim.api.nvim_command(cmd)
                  -- just for lazygit
                  vim.schedule(function()
                    vim.api.nvim_command "LazyGit"
                  end)
                end,
              },
            },
          },
          Ask = {
            handler = tools.disposable_ask_handler,
            opts = {
              position = {
                row = 2,
                col = 0,
              },
              title = " Ask ",
              inline_assistant = true,

              -- Whether to use the current buffer as context without selecting any text (the tool is called in normal mode)
              enable_buffer_context = true,
              language = "English",

              -- display diff
              display = {
                mapping = {
                  mode = "n",
                  keys = { "d" },
                },
                action = nil,
              },
              -- accept diff
              accept = {
                mapping = {
                  mode = "n",
                  keys = { "Y", "y" },
                },
                action = nil,
              },
              -- reject diff
              reject = {
                mapping = {
                  mode = "n",
                  keys = { "N", "n" },
                },
                action = nil,
              },
              -- close diff
              close = {
                mapping = {
                  mode = "n",
                  keys = { "<esc>" },
                },
                action = nil,
              },
            },
          },
        },
      }
    end,
    keys = {
      { "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>" },
    },
  },
}
