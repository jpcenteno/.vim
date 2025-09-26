local cli = require("zettelkasten.cli")
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

return M
