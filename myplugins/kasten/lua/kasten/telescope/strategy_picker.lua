local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local conf = require("telescope.config").values
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")

local M = {}

--- Creates a picker that lets the user choose between a list of callbacks to
--- continue execution. It is called strategy picker because it reminds me of
--- the strategy pattern.
---
--- @generic T any
--- @alias NamedStrategy { name: string, f: fun(data: T): nil }
---
--- @param opts table Options to pass to the picker.
--- @param strategies NamedStrategy[]
--- @param data T Data to pass to the chosen f.
M.strategy_picker = function(opts, strategies, data)
  opts = opts or {}

  --- @alias Entry { value: NamedStrategy, display: string, ordinal: string }
  --- @param tbl NamedStrategy
  --- @return Entry
  local entry_maker = function(tbl)
    return {
      value = tbl,
      display = tbl.name,
      ordinal = tbl.name,
    }
  end

  --- @param prompt_bufnr number
  local attach_mappings = function(prompt_bufnr, _)
    actions.select_default:replace(function()
      actions.close(prompt_bufnr) -- Close the picker popup.
      local selection = action_state.get_selected_entry() --[[@as Entry]]

      print(vim.inspect({ selection = selection })) -- FIXME delete this.

      if selection then
        selection.value.f(data)
      end
    end)
    return true
  end

  pickers
    .new(opts, {
      prompt_title = opts.title or "Select an Option",
      finder = finders.new_table({
        results = strategies,
        entry_maker = entry_maker,
      }),
      sorter = conf.generic_sorter(opts),
      attach_mappings = attach_mappings,
    })
    :find()
end

return M
