local action_state = require('telescope.actions.state')
local actions = require('telescope.actions')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local telescope_config = require("telescope.config")

local cli = require("kasten.cli")

local M = {}

M.find_notes = function(opts)
  pickers.new({}, {
    prompt_title = opts.prompt_title or "Notes",
    finder = finders.new_table({
      results = cli.note_list({}),
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
