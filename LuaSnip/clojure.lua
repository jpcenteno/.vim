local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

ls.add_snippets("clojure", {
  s("reqspec", t("[clojure.spec.alpha :as s]")),
  s("reqstring", t("[clojure.string :as str]")),
  s("reqtest", t("[clojure.test :refer [deftest is testing]]")),
  s("unimplemented", t('(throw (UnsupportedOperationException. "Unimplemented!"))')),
})
