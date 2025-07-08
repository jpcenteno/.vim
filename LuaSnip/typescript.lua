local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("typescript", {
  -- Anonymous functions:
  s("af", fmt("( {} ) => {{{}}}", { i(1), i(0) })),
  s("aaf", fmt("async ( {} ) => {{{}}}", { i(1), i(0) })),

  -- Types:
  s("brand", fmt("& {{ readonly __brand: unique symbol }}", {})),

  -- Testing:
  s("describe", fmt('describe("{}", () => {{\n  {}\n}})', { i(1), i(2) })),
  s("it", fmt('it("{}", () => {{\n  {}\n}})', { i(1), i(2) })),
  s("ita", fmt('it("{}", async () => {{\n  {}\n}})', { i(1), i(2) })),
})
