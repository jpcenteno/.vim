local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local telescope_config = require("telescope.config")
local path = require("plenary.path")
local utils_buffer = require("kasten.utils.buffer")

local cli = require("kasten.cli")

--- Ask user for confirmation using the native `vim.ui.input`.
---
--- @param prompt string
--- @return boolean
local function confirm(prompt)
  local ans = nil

  while ans ~= "y" and ans ~= "n" do
    vim.ui.input({
      prompt = prompt .. " (y/n) ",
      cancelreturn = "n",
    }, function(input)
      ans = string.lower(input)
    end)
  end

  return ans == "y"
end

local M = {}

M.find_notes = function(opts)
  pickers
      .new({}, {
        prompt_title = opts.prompt_title or "Notes",
        finder = finders.new_table({
          results = cli.note_list({}),
          entry_maker = function(entry)
            return {
              value = entry,
              display = entry.title,
              ordinal = entry.title,
            }
          end,
        }),
        sorter = telescope_config.values.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, _)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            opts.select_default()
          end)

          return true
        end,
      })
      :find()
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
    select_default = select_default,
  })
end

function M.insert_link()
  local select_default = function()
    local selection = action_state.get_selected_entry()
    if selection then
      local relativePath = "./" .. selection.value.relativePath
      require("kasten.link").insert_link_to_note_visual(relativePath)
    else
      local current_line = action_state.get_current_line()
      if confirm("Create new note '" .. current_line .. "'?") then
        local note = cli.note_new({ title = current_line })
        require("kasten.link").insert_link_to_note_visual(note.relativePath)
      end
    end
  end

  M.find_notes({
    prompt_title = "Link to note",
    select_default = select_default,
  })
end

-- Set `pickers.buffers.entry_maker` to this function when calling
-- `require("telescope").setup({...})` to display zettel titles instead of their
-- file paths.
function M.buffers_picker_entry_maker(opts)
  opts = opts or {}
  opts.bufnr_width = opts.bufnr_width or 4

  local entry_maker = require("telescope.make_entry").gen_from_buffer(opts)

  return function(buffer)
    local entry = entry_maker(buffer)
    if utils_buffer.is_zettel(entry.bufnr) then
      local title = utils_buffer.get_title(entry.bufnr) or "[ Untitled zettel ]"
      entry.filename = title
      entry.ordinal = entry.bufnr .. " : " .. title
    end

    return entry
  end
end

return M
