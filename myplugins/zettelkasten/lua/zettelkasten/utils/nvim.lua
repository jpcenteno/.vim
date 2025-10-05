local M = {}

function M.is_visual_mode()
  return vim.fn.mode():match("[vV\22]")
end

---Asserts that the current mode is visual mode or throws an error.
---@param msg string?
M.assert_visual_mode = function(msg)
  assert(M.is_visual_mode(), msg)
end

--- Returns the parent directory of the buffer.
--- @param buffer integer
--- @return string
M.buf_get_directory = function(buffer)
  local file_path = vim.api.nvim_buf_get_name(buffer)
  return vim.fn.fnamemodify(file_path, ":h")
end

function M.press_esc()
  local keys = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end

return M
