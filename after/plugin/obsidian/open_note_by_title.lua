local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local obsidian = require("obsidian")

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║ Thread-safe note index                                                ║
-- ║                                                                       ║
-- ║ This class allows async callbacks to collect all the notes without    ║
-- ║ fear of race-conditions.                                              ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local ThreadSafeNoteIndex = {}
ThreadSafeNoteIndex.__index = ThreadSafeNoteIndex

local function new_thread_safe_note_index()
  local self = setmetatable({}, ThreadSafeNoteIndex)
  self._notes_by_filename = {}
  return self
end

-- Insert a note. Will ignore notes without title.
function ThreadSafeNoteIndex:insert_note(note)
    if (note.metadata ~= nil) and (note.metadata.title ~= nil) then
      self._notes_by_filename[note.path.filename] = note
    end
end

-- Returns a list with all the notes.
function ThreadSafeNoteIndex:get_notes()
  local notes_list = {}
  for _, note in pairs(self._notes_by_filename) do
    table.insert(notes_list, note)
  end
  return notes_list
end

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║ Telescope picker implementation                                       ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local open_note_by_title = function(opts)
  opts = opts or {}

  local notes = new_thread_safe_note_index()

  -- Returns an "entry" table in the format expected by Telescope.
  local entry_maker = function (note)
    local title = note.metadata.title
    local filename = note.path.filename
    return {
      value = { title, filename },
      display = title,
      ordinal = title,
      path = filename,
    }
  end

  local on_note_async_callback = function (note)
    notes:insert_note(note)
  end

  local on_end = function ()
    -- NOTE: We have to run the picker here because only at this point we know
    -- that all notes have been indexed.
    pickers.new(opts, {
      prompt_title = "Open notes",
      finder = finders.new_table {
        results = notes:get_notes(),
        entry_maker = entry_maker,
      },
      sorter = conf.generic_sorter(opts),
      previewer = conf.grep_previewer(opts),
    }):find()
  end

  -- This function processes each note asynchronously. Then calls the `on_end`
  -- callback once all notes are processed. It is necessary to launch the finder
  obsidian.get_client():apply_async(on_note_async_callback, on_end)
end

vim.api.nvim_create_user_command(
  "OpenNoteByTitle",
  open_note_by_title,
  { desc = "Open a note by its title using Telescope" }
)
