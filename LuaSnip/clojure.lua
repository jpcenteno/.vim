local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

ls.add_snippets("clojure", {
  s("unimplemented", t("(throw (UnsupportedOperationException. \"Unimplemented!\"))"))
})
