return {
  "nvim-mini/mini.ai",
  event = "VeryLazy",
  version = "*",
  config = function()
    require("mini.ai").setup {
      -- Table with textobject id as fields, textobject specification as values.
      -- Also use this to disable builtin textobjects. See |MiniAi.config|.
      custom_textobjects = nil,

      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Main textobject prefixes
        around = "a",
        inside = "i",

        -- Next/last variants
        -- NOTE: This (deliberately) overrides Neovim>=0.12 built-in incremental
        -- selection mappings. See [`:h MiniAi-default-an-in`](../doc/mini-ai.qmd#miniai-default-an-in) for more details.
        around_next = "an",
        inside_next = "in",
        around_last = "al",
        inside_last = "il",

        -- Move cursor to corresponding edge of `a` textobject
        goto_left = "g[",
        goto_right = "g]",
      },

      -- Number of lines within which textobject is searched
      n_lines = 50,

      -- How to search for object (first inside current line, then inside
      -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
      -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
      search_method = "cover_or_next",

      -- Whether to disable showing non-error feedback
      -- This also affects (purely informational) helper messages shown after
      -- idle time if user input is required.
      silent = false,
    }
  end,
}

-- ┌───┬───────────────┬──────────────────┬────────┬────────┬────────┬────────┐
-- │Key│     Name      │   Example line   │   a    │   i    │   2a   │   2i   │
-- ├───┴───────────────┴──────────────────┴────────┴────────┴────────┴────────┤
-- ├┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈1234567890123456┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┤
-- │ ( │  Balanced ()  │ (( *a (bb) ))    │        │        │        │        │
-- │ [ │  Balanced []  │ [[ *a [bb] ]]    │ [2;12] │ [4;10] │ [1;13] │ [2;12] │
-- │ { │  Balanced {}  │ {{ *a {bb} }}    │        │        │        │        │
-- │ < │  Balanced <>  │ << *a <bb> >>    │        │        │        │        │
-- ├┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈1234567890123456┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┤
-- │ ) │  Balanced ()  │ (( *a (bb) ))    │        │        │        │        │
-- │ ] │  Balanced []  │ [[ *a [bb] ]]    │        │        │        │        │
-- │ } │  Balanced {}  │ {{ *a {bb} }}    │ [2;12] │ [3;11] │ [1;13] │ [2;12] │
-- │ > │  Balanced <>  │ << *a <bb> >>    │        │        │        │        │
-- │ b │  Alias for    │ [( *a {bb} )]    │        │        │        │        │
-- │   │  ), ], or }   │                  │        │        │        │        │
-- ├┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈1234567890123456┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┤
-- │ " │  Balanced "   │ "*a" " bb "      │        │        │        │        │
-- │ ' │  Balanced '   │ '*a' ' bb '      │        │        │        │        │
-- │ ` │  Balanced `   │ `*a` ` bb `      │ [1;4]  │ [2;3]  │ [6;11] │ [7;10] │
-- │ q │  Alias for    │ '*a' " bb "      │        │        │        │        │
-- │   │  ", ', or `   │                  │        │        │        │        │
-- ├┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈1234567890123456┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┤
-- │ ? │  User prompt  │ e*e o e o o      │ [3;5]  │ [4;4]  │ [7;9]  │ [8;8]  │
-- │   │(typed e and o)│                  │        │        │        │        │
-- ├┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈1234567890123456┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┤
-- │ t │      Tag      │ <x><y>*a</y></x> │ [4;12] │ [7;8]  │ [1;16] │ [4;12] │
-- ├┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈1234567890123456┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┤
-- │ f │ Function call │ f(a, g(*b, c) )  │ [6;13] │ [8;12] │ [1;15] │ [3;14] │
-- ├┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈1234567890123456┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┤
-- │ a │   Argument    │ f(*a, g(b, c) )  │ [3;5]  │ [3;4]  │ [5;14] │ [7;13] │
-- ├┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈1234567890123456┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┤
-- │   │    Default    │ aa_*b__cc___     │ [4;7]  │ [4;5]  │ [8;12] │ [8;9]  │
-- │   │   (typed _)   │                  │        │        │        │        │
-- └───┴───────────────┴──────────────────┴────────┴────────┴────────┴────────┘
