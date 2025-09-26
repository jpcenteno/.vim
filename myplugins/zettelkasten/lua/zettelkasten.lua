local M = {}

--- @return nil
M.new_note = function()
  vim.ui.input({ prompt = "Create a note with title: " }, function(title)
    -- Do nothing in case the user aborted the prompt.
    if title == nil then
      return nil
    end
    ---@cast title string

    local note = require("zettelkasten.cli").note_new(title)

    vim.cmd.edit(note.location)
  end)
end

return M
