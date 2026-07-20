return {
  "Olical/conjure",
  ft = { "clojure", "lua" },
  dependencies = {
    {
      "PaterJason/cmp-conjure",
      dependencies = { "hrsh7th/nvim-cmp" },
      config = function()
        local cmp = require("cmp")
        local config = cmp.get_config()
        table.insert(config.sources, { name = "conjure" })
        cmp.setup(config)
      end,
    },
  },
}
