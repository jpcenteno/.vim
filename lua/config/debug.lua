local M = {}

--- Opens a new buffer displaying the runtime path.
M.display_runtime_path = function()
  vim.cmd("new")

  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.opt.runtimepath:get())

  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false
  vim.bo.modifiable = false
  vim.bo.readonly = true
end

return M
