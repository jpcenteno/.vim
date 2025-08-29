return {
  'L3MON4D3/LuaSnip',
  version = "v2.*",
	-- build = "make install_jsregexp" -- install jsregexp (optional!).
  dependencies = {
    'rafamadriz/friendly-snippets' --  Set of preconfigured snippets for different languages.
  },
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/LuaSnip" })
  end
}
