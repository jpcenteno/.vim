-- This module exports a collection of cross-compatible snippets
-- for different languages in the JavaScript family (e.g. TypeScript).
--
-- ## Usage examples
--
-- ```lua
-- -- LuaSnip/typescript.lua
-- ls.add_snippets("typescript", require("config.luasnip.javascript_language_family"))
-- ```

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt


return {
  -- Anonymous functions:

  s(
    "af",
    fmt(
      "( {} ) => {{{}}}",
      { i(1), i(0) }
    )
  ),

  s(
    "aaf",
    fmt(
      "async ( {} ) => {{{}}}",
      { i(1), i(0) }
    )
  ),

  s(
    "iife",
    fmt(
      "(() => {{{}}})()",
      { i(1), }
    )
  ),


  -- Development Lifecycle:

  s(
    "unimplemented",
    fmt(
      [[
      throw new Error("Unimplemented");
      ]],
      {}
    )
  ),

  -- Control Flow:
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

  -- Testing:
  --
  s(
    "describe",
    fmt(
      'describe("{}", () => {{\n  {}\n}})',
      { i(1), i(2) }
    )
  ),

  s(
    "it",
    fmt(
      'it("{}", () => {{\n  {}\n}})',
      { i(1), i(2) }
    )
  ),

  s(
    "ita",
    fmt(
      'it("{}", async () => {{\n  {}\n}})',
      { i(1), i(2) }
    )
  ),
}
