local open_note_by_alias = function()
  local aliases_and_filenames = {}

  -- This callback gets applied asynchronously to every note. It appends all
  -- it's aliases to the `aliases_and_filenames` table.
  local on_note = function(note)
    if note.aliases then
      for _, alias in ipairs(note.aliases) do
        table.insert(aliases_and_filenames, { alias, note.path.filename })
      end
    end
  end

  -- Callback to execute once every note has been handled by `apply_async`.
  -- Opens a telescope picker that allows the user to open a note by alias.
  local on_done = function()
    local pickers = require "telescope.pickers"
    local finders = require "telescope.finders"
    local conf = require("telescope.config").values

    -- This function gets called on each `{ alias, filename }` tuple returning a
    -- table that the finder can make use of.
    local entry_maker = function(entry)
      return {
        value = entry,
        display = entry[1],
        ordinal = entry[1],
        path = entry[2],
      }
    end

    local opts = {}
    pickers.new(opts, {
      prompt_title = "Note aliases",
      finder = finders.new_table {
        results = aliases_and_filenames,
        entry_maker = entry_maker,
      },
      sorter = conf.generic_sorter(opts)
    }):find()
  end

  local obsidian_client = require("obsidian").get_client()
  obsidian_client:apply_async(on_note, on_done)
end

vim.api.nvim_create_user_command(
  "OpenNoteByAlias",
  open_note_by_alias,
  { desc = "Open a note by its alias using telescope" }
)
