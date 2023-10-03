local telescope = require("telescope")

telescope.setup()

-- Use the `fzy_native` sorter for better performance.
--
-- Note to self: I disregarded the `nvim-telescope/telescope-fzf-native.nvim`
-- sorter because it depended on Cmake, which I would prefer to avoid because it
-- sucks. I should tottaly ensure that fzy_native builds correctly on hosts like
-- Alpine Linux.
telescope.load_extension("fzy_native")
