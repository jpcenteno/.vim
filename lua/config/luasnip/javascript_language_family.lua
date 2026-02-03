-- This module exports a collection of cross-compatible snippets
-- for different languages in the JavaScript family (e.g. TypeScript).

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt


return {
  s(
    "unimplemented",
    fmt(
      [[
      throw new Error("Unimplemented");
      ]],
      {}
    )
  ),

  s(
    "else",
    fmt(
      [[
      else {{
        {}
      }}
      ]],
      {
        i(1),
      }
    )
  ),
}
