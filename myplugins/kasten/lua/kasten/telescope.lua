local action_state = require('telescope.actions.state')
local actions = require('telescope.actions')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local telescope_config = require("telescope.config")

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

local M = {}

M.find_notes = function(opts)
  pickers.new({}, {
    prompt_title = opts.prompt_title or "Notes",
    finder = finders.new_table({
      results = list_notes(),
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.title,
          ordinal = entry.title,
        }
      end
    }),
    sorter = telescope_config.values.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        opts.select_default()
      end)

      return true
    end,
  }):find()
end

function M.note_open()
  local select_default = function()
    local selection = action_state.get_selected_entry()
    if selection then
      local filepath = selection.value.absolutePath
      vim.cmd("edit " .. vim.fn.fnameescape(filepath))
    end
  end

  M.find_notes({
    prompt_title = "Open note",
    select_default = select_default
  })
end

function M.insert_link()
  local select_default = function()
    local selection = action_state.get_selected_entry()
    if selection then
      local relativePath = "./" .. selection.value.relativePath
      require("kasten.link").insert_link_to_note_visual(relativePath)
    end
  end

  M.find_notes({
    prompt_title = "Link to note",
    select_default = select_default
  })
end

return M
