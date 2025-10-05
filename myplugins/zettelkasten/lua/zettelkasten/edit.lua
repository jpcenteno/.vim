local nvim_utils = require("zettelkasten.utils.nvim")
local path_utils = require("zettelkasten.utils.path")
local pickers = require("zettelkasten.pickers")

local M = {}

---Inserts the string `s` at position.
---@param position zettelkasten.utils.nvim.position.Position
---@param s string
local function insert_at_position(position, s)
  local line_pre = vim.api.nvim_buf_get_lines(0, position.row - 1, position.row, true)[1]
  local left = line_pre:sub(1, position.column - 1)
  local right = line_pre:sub(position.column)
  local line_post = left .. s .. right
  vim.api.nvim_buf_set_lines(0, position.row - 1, position.row, true, { line_post })
end

--- Surrounds the text of a single-line visual range.
--- @param visual_range VisualRange
--- @param prefix string
--- @param suffix string
local function surround_single_line(visual_range, prefix, suffix)
  assert(visual_range:is_single_line())

  local row = visual_range.from.row
  local line = vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]

  local left = line:sub(1, visual_range.from.column - 1)
  local center = line:sub(visual_range.from.column, visual_range.to.column)
  local right = line:sub(visual_range.to.column + 1)

  local surrounded = left .. prefix .. center .. suffix .. right
  vim.api.nvim_buf_set_lines(0, row - 1, row, true, { surrounded })
end

--- Surrounds the text of a multi-line visual range.
--- @param visual_range VisualRange
--- @param prefix string
--- @param suffix string
local function surround_multi_line(visual_range, prefix, suffix)
  assert(not visual_range:is_single_line())

  insert_at_position(visual_range.from, prefix)
  vim.notify(vim.inspect(visual_range.to))
  insert_at_position(visual_range.to:offset_column(1), suffix)
end

--- Surrounds a range within the buffer with the `left` and `right` srings.
---
--- @param visual_range VisualRange
--- @param left string
--- @param right string
function M.surround(visual_range, left, right)
  if visual_range:is_single_line() then
    surround_single_line(visual_range, left, right)
  else
    surround_multi_line(visual_range, left, right)
  end
end

M.surround_visual_selection_with_link_to_note = function()
  nvim_utils.assert_visual_mode()

  --- Current visual range start position.
  local _, row1, col1, _ = unpack(vim.fn.getpos("v"))
  local row2, col2 = unpack(vim.api.nvim_win_get_cursor(0))
  col2 = col2 + 1

  if (row2 < row1) or (row1 == row2 and col2 < col1) then
    row1, row2 = row2, row1
    col1, col2 = col2, col1
  end

  pickers.pick_note({
    confirm = function(picker, selected_item)
      picker:close()
      local url = path_utils.relative_to_parent_directory(selected_item.file)

      if row1 == row2 then
        local line = vim.api.nvim_buf_get_lines(0, row1 - 1, row1, true)[1]
        local left = line:sub(1, col1 - 1)
        local center = line:sub(col1, col2)
        local right = line:sub(col2 + 1)

        local wrapped_line = left .. "[" .. center .. "](" .. url .. ")" .. right

        vim.api.nvim_buf_set_lines(0, row1 - 1, row1, true, { wrapped_line })
      else
        local line1 = vim.api.nvim_buf_get_lines(0, row1 - 1, row1, true)[1]
        local left1 = line1:sub(1, col1 - 1)
        local right1 = line1:sub(col1)
        local wrapped_line1 = left1 .. "[" .. right1
        vim.api.nvim_buf_set_lines(0, row1 - 1, row1, true, { wrapped_line1 })

        local line2 = vim.api.nvim_buf_get_lines(0, row2 - 1, row2, true)[1]
        local left2 = line2:sub(1, col2)
        local right2 = line2:sub(col2 + 1)
        local wrapped_line2 = left2 .. "](" .. url .. ")" .. right2
        vim.api.nvim_buf_set_lines(0, row2 - 1, row2, true, { wrapped_line2 })
      end

      nvim_utils.press_esc()
    end,
  })
end

return M
