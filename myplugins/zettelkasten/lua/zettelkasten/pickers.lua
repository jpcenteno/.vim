local cli = require("zettelkasten.cli")
local table_utils = require("zettelkasten.utils.table")

local snacks = require("snacks")

local M = {}

--- Opens a picker with the titles of each note in the zettelkasten. Opens a
--- note for editing on confirmation.
M.open_note = function()
  local notes = cli.note_list()

  local items = {}
  for _, note in ipairs(notes) do
    items[#items + 1] = {
      file = note.location,
      text = note.title,
    }
  end

  snacks.picker.pick({
    items = items,
    format = "text", -- Display the `text` field instead of the `file`.
  })
end

--- Pick notes from the zettelkasten.
--- @param opts table?
M.pick_note = function(opts)
  local notes = cli.note_list()

  local items = {}
  for _, note in ipairs(notes) do
    items[#items + 1] = {
      file = note.location,
      text = note.title,
    }
  end

  local mutable_opts = table_utils.shallow_copy(opts or {})
  mutable_opts.items = items
  mutable_opts.format = "text" -- Display the `text` field instead of the `file`.

  snacks.picker.pick(mutable_opts)
end

return M
