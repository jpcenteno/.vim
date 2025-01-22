local luasnip = require("luasnip")
local snippet = luasnip.snippet;
local t = luasnip.text_node
local i = luasnip.insert_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/LuaSnip/" })

luasnip.add_snippets("clojure", {
  snippet("reqspec", { t("[clojure.spec.alpha :as s]") }),
  snippet("reqstring", { t("[clojure.string :as str]") }),
  snippet("reqtest", { t("[clojure.test :refer [deftest is testing]]") }),
})

luasnip.add_snippets("nix", {
  snippet("module", fmt([[
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
    { i(1), rep(1), i(2), i(3) }))
})
