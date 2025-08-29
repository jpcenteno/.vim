local luasnip = require("luasnip")
local s = luasnip.snippet
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local i = luasnip.insert_node
local t = luasnip.text_node

luasnip.add_snippets("nix", {
  s(
    "module",
    fmt(
      [[
        {{ config, lib, ... }}:
        let
          cfg = config.{};
        in {{
          options.{} = {{
            enable = lib.mkEnableOption "{}";
          }};

          config = lib.mkIf cfg.enable {{
            {}
          }};
        }}
      ]],
      { i(1), rep(1), i(2), i(3) }
    )
  ),
})
