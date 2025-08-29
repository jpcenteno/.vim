local kasten_telescope = require("kasten.telescope")
local telescope = require("telescope")

telescope.setup({
  defaults = {
    -- You need the `nvim-tree/nvim-web-devicons` package, not the
    -- `ryanoasis/vim-devicons` package for devicons to appear.
    --
    -- I'm disabling the default colors because they conflict with my
    -- colorscheme.
    color_devicons = false,
  },
  pickers = {
    buffers = {
      entry_maker = kasten_telescope.buffers_picker_entry_maker(),
    },
  },
})

-- Use the `fzy_native` sorter for better performance.
--
-- Note to self: I disregarded the `nvim-telescope/telescope-fzf-native.nvim`
-- sorter because it depended on Cmake, which I would prefer to avoid because it
-- sucks. I should tottaly ensure that fzy_native builds correctly on hosts like
-- Alpine Linux.
telescope.load_extension("fzy_native")
