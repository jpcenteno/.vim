local function list_notes()
  local handle = io.popen("kasten-cli note list --json", "r")
  if not handle then
    error("Failed to execute `kasten-cli note list`")
  end

  local result = handle:read("*a")
  handle:close()

  local success, notes = pcall(vim.json.decode, result)
  if not success then
    error("Failed to parse JSON output from `kasten-cli note list`")
  end

  if #notes == 0 then
    error("No notes found")
  end

  return notes
end

local note_picker = require('telescope.pickers').new({}, {
  prompt_title = 'Open note',
  finder = require('telescope.finders').new_table({
    results = list_notes(),
    entry_maker = function(entry)
      return {
        value = entry,
        display = entry.title,
        ordinal = entry.title,
      }
    end
  }),
  sorter = require("telescope.config").values.generic_sorter({}),
  attach_mappings = function(prompt_bufnr, _)
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')

    actions.select_default:replace(function()
      actions.close(prompt_bufnr)
      local selection = action_state.get_selected_entry()
      if selection then
        local filepath = selection.value.absolutePath
        vim.cmd("edit " .. vim.fn.fnameescape(filepath))
      end
    end)

    return true
  end,
})

local M = {}

function M.note_open()
  note_picker:find()
end

return M
