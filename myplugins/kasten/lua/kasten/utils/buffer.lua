local utils_config = require("kasten.utils.config")

local M = {}

M.is_zettel = function(bufnr)
  local kasten_dir = utils_config.get_kasten_dir()
  local filename = vim.api.nvim_buf_get_name(bufnr)
  return filename:sub(1, #kasten_dir) == kasten_dir
end

M.get_title = function(bufnr)
  if M.is_zettel(bufnr) and vim.api.nvim_buf_is_loaded(bufnr) then
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    for _, line in ipairs(lines) do
      local match = line:match("^title:%s*(.+)")
      if match then
        return match
      end
    end
  end

  return nil
end

return M
