local nvim_utils = require("zettelkasten.utils.nvim")
local path_utils = require("zettelkasten.utils.path")
local pickers = require("zettelkasten.pickers")

local M = {}

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
