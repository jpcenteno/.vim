local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("typescript", require("config.luasnip.javascript_language_family"))

ls.add_snippets("typescript", {
  -- Types:
  s("brand", fmt("& {{ readonly __brand: unique symbol }}", {})),
})
