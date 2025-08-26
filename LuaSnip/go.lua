local luasnip = require("luasnip")
local s = luasnip.snippet
local fmt = require("luasnip.extras.fmt").fmt
local i = luasnip.insert_node

luasnip.add_snippets("go", {
  s(
    "unimplemented",
    fmt(
      [[
      panic("{name} not implemented")
      ]],
      {
        name = i(1, "Function"),
      }
    )
  ),

  s(
    "iferr",
    fmt(
      [[
      if err != nil {{
        {body}
      }}
      ]],
      {
        body = i(1, ""),
      }
    )
  ),
})
