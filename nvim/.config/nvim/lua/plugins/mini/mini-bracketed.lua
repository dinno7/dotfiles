return {
  "nvim-mini/mini.bracketed",
  event = "VeryLazy",
  version = "*",
  config = function()
    require("mini.bracketed").setup()
  end,
}

--+---------------------------------------------------+-------------+----------------------------+
--|                      Target                       |  Mappings   |        Lua function        |
--+---------------------------------------------------+-------------+----------------------------+
--| Buffer                                            | [B [b ]b ]B | MiniBracketed.buffer()     |
--| Comment block                                     | [C [c ]c ]C | MiniBracketed.comment()    |
--| Conflict marker                                   | [X [x ]x ]X | MiniBracketed.conflict()   |
--| Diagnostic                                        | [D [d ]d ]D | MiniBracketed.diagnostic() |
--| File on disk                                      | [F [f ]f ]F | MiniBracketed.file()       |
--| Indent change                                     | [I [i ]i ]I | MiniBracketed.indent()     |
--| Jump from jumplist inside current buffer          | [J [j ]j ]J | MiniBracketed.jump()       |
--| Location from location list                       | [L [l ]l ]L | MiniBracketed.location()   |
--| Old files                                         | [O [o ]o ]O | MiniBracketed.oldfile()    |
--| Quickfix entry from quickfix list                 | [Q [q ]q ]Q | MiniBracketed.quickfix()   |
--| Tree-sitter node and parents                      | [T [t ]t ]T | MiniBracketed.treesitter() |
--| Undo states from specially tracked linear history | [U [u ]u ]U | MiniBracketed.undo()       |
--| Window in current tab                             | [W [w ]w ]W | MiniBracketed.window()     |
--| Yank selection replacing latest put region        | [Y [y ]y ]Y | MiniBracketed.yank()       |
--+---------------------------------------------------+-------------+----------------------------+
