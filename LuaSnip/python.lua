local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

ls.add_snippets("python", {
  s("#!", t("#! /usr/bin/env python3")),
})
