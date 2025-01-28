local M = {}

function M.note_open()
  local handle = io.popen("kasten-cli note list --json", "r")
  if not handle then
    vim.notify("Failed to execute `kasten-cli note list`", vim.log.levels.ERROR)
    return
  end

  local result = handle:read("*a")
  handle:close()

  local success, notes = pcall(vim.json.decode, result)
  if not success then
    vim.notify("Failed to parse JSON output from `kasten-cli note list`", vim.log.levels.ERROR)
    return
  end

  if #notes == 0 then
    vim.notify("No notes found", vim.log.levels.WARN)
    return
  end

  local pick_items = {}
  for _, note in ipairs(notes) do
    table.insert(pick_items, {
      title = note.title,
      path = note.absolutePath
    })
  end

  require('telescope.pickers').new({}, {
    prompt_title = 'Note Zettels',
    finder = require('telescope.finders').new_table({
      results = pick_items,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.title,
          ordinal = entry.title,
        }
      end
    }),
    sorter = require("telescope.config").values.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')

      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection then
          local filepath = selection.value.path
          vim.cmd("edit " .. vim.fn.fnameescape(filepath))
        end
      end)

      return true
    end,
  }):find()
end

return M
