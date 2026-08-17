" ------------------------------------------------------------------------------
" Basic Config:
" ------------------------------------------------------------------------------


set noswapfile

" Keep the buffers hidden when closed.
set hidden

" Perform case-insensitive searches unless the search contains uppercase
" characters.
set smartcase

set completeopt=menu,menuone,noselect

lua require("config.text").setup({})
lua require("config.keys").setup({})
lua require("config.lazy")
lua require("config.debug").setup({})
lua require("config.aesthetics").setup({})
