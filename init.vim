" ------------------------------------------------------------------------------
" Basic Config:
" ------------------------------------------------------------------------------

set completeopt=menu,menuone,noselect

lua require("config.text").setup({})
lua require("config.keys").setup({})
lua require("config.lazy")
lua require("config.debug").setup({})
lua require("config.aesthetics").setup({})
