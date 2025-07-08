local path = require("plenary.path")
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
      entry_maker = (function()
        local original_entry_maker = require("telescope.make_entry").gen_from_buffer({
          bufnr_width = 4
        })

        local is_zettel = function(entry)
          -- Get the location of the zettelkasten directory.
          local kasten_dir = os.getenv("KASTEN_DIR")
          if not kasten_dir then
            return false
          end

          -- Get and normalize the filename
          local filename = tostring(path:new(entry.filename):expand())

          -- Return true if and only if the normalized path starts with the
          -- kasten dir.
          return filename:sub(1, #kasten_dir) == kasten_dir
        end

        local get_title = function(bufnr)
          if bufnr and vim.api.nvim_buf_is_loaded(bufnr) then
            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
            for _, line in ipairs(lines) do
              local match = line:match("^title:%s*(.+)")
              if match then
                return match
              end
            end
          end

          return nil
        end

        local patch_note_buffer_name = function(entry)
          if is_zettel(entry) then
            local bufnr = entry.bufnr or entry.value.bufnr
            local title = get_title(bufnr) or "[ Untitled zetteo ]"
            if title then
              entry.filename = title
              entry.ordinal = entry.bufnr .. " : " .. title
            end
          end

          return entry
        end


        return function(buffer)
          local entry = original_entry_maker(buffer)

          return patch_note_buffer_name(entry)
        end
      end)()

    }
  }
})

-- Use the `fzy_native` sorter for better performance.
--
-- Note to self: I disregarded the `nvim-telescope/telescope-fzf-native.nvim`
-- sorter because it depended on Cmake, which I would prefer to avoid because it
-- sucks. I should tottaly ensure that fzy_native builds correctly on hosts like
-- Alpine Linux.
telescope.load_extension("fzy_native")
