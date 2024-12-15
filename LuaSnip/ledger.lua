local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

math.randomseed( os.time() ) -- Prevent UUID collisions.

local function uuid()
  -- Source: https://gist.github.com/jrus/3197011
  local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
  return string.gsub(template, '[xy]', function (c)
    local v = (function ()
      if c == 'x' then
        return math.random(0x0, 0xf)
      else
        return math.random(0x8, 0xb) -- Must start with 0b10
      end
    end)()
    return string.format('%x', v)
  end)
end

local function fmt_metadata_snippet(k, v)
  return { t("; "), k, t(": "), v } -- `; {k}: {v}`
end

local metadata_uuid_snippet = fmt_metadata_snippet(
  t("uuid"),
  f(function (_, _, _) return uuid() end)
)

ls.add_snippets("ledger", {
  s(
    "tx",
    fmt(
      [[
      {year}-{month}-{day} {description}
          ; UUID: {uuid}
          {postings}
      ]],
      {
        year = i(1, os.date("%Y")),
        month = i(2, os.date("%m")),
        day = i(3, os.date("%d")),
        description = i(4, "Description"),
        uuid = f(function (_, _, _) return uuid() end),
        postings = i(5)
      }
    )
  ),

  s(
    "metadata",
    fmt(
      [[
        ; {key}: {value}
      ]],
      {
        key = i(1, "Key"),
        value = i(2, "value"),
      }
    )
  ),

  s(
    "metadata-uuid",
    fmt(
      [[
        ; UUID: {uuid}
      ]],
      { uuid = f(function (_, _, _) return uuid() end) }
    )
  ),
})
