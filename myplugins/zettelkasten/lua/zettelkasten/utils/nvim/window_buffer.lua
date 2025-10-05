--- Context: Visual selections relate to windows. The same buffer could be open
--- in different windows and be in different modes with different cursor
--- positions.

local VisualRange = require("zettelkasten.utils.nvim.visualrange")

--- @class zettelkasten.utils.nvim.WindowBuffer
--- @field window_id integer
--- @field buffer_id integer
local WindowBuffer = {}

function WindowBuffer:new(window_id)
  assert(type(window_id) == "number" and window_id % 1 == 0 and window_id ~= 0)
  local buffer_id = vim.api.nvim_win_get_buf(window_id)

  return { window_id = window_id, buffer_id = buffer_id }
end

function WindowBuffer:current_window()
  local window_id = vim.api.nvim_win_get_number(0)
  return self:new(window_id)
end

function WindowBuffer:mode()
  local cur_win = vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(self.window_id)
  local mode = vim.api.nvim_get_mode().mode
  vim.api.nvim_set_current_win(cur_win)
  return mode
end

function WindowBuffer:selection_start()
  local cur_win = vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(self.window_id)
  local position = Position
  vim.api.nvim_set_current_win(cur_win)
  return mode
end

--- Returns the visual selection range.
--- @return VisualRange
function WindowBuffer:visual_range()
  local mode = self:mode()
  local from = self:selection_start()
  local to = self:cursor_position()
  return VisualRange:new(mode, from, to)
end

local M = {}

function M.new(window_id)
  assert(type(window_id) == "number" and window_id % 1 == 0 and window_id ~= 0)
  local buffer_id = vim.api.nvim_win_get_buf(window_id)

  local o = { window_id = window_id, buffer_id = buffer_id }
  setmetatable(o, { __index = WindowBuffer })
  return o
end

function M.current_window()
  local window_id = vim.api.nvim_win_get_number(0)
  return M.new(window_id)
end

return WindowBuffer
