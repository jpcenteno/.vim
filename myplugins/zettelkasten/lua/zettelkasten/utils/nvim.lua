local M = {}

function M.is_visual_mode()
  return vim.fn.mode():match("[vV\22]")
end

---Asserts that the current mode is visual mode or throws an error.
---@param msg string?
M.assert_visual_mode = function(msg)
  assert(M.is_visual_mode(), msg)
end

function M.press_esc()
  local keys = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end

return M
