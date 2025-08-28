local M = {}

M.note_open = function()
  local notes = require('kasten.cli').note_list({})

  local items = {}
  for idx, note in ipairs(notes) do
    table.insert(items, {
      idx = idx,
      score = idx,
      text = note.title,
      file = note.absolutePath
    })
  end

  require('snacks.picker').pick({
    format = "text",
    items = items,
  })
end

M.note_open() -- FIXME delete this

return M
