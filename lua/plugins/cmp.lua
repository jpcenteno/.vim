return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-buffer',
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    -- FIXME move luasnip config here.
    'saadparwaiz1/cmp_luasnip',
  },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
      -- FIXME move luasnip configuration here.
      snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),

      -- FIXME document how does this work. Does it activate the next array if
      -- one of the previous ones doesn't have sources available?
      sources = cmp.config.sources(
        {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = "path" },
        },
        {
          { name = 'buffer' }, -- Fallback to same behavior as Neovim.
        }
      )
    })
  end,
}
