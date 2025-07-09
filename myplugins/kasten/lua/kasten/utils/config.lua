local M = {}

M.get_kasten_dir = function()
  return os.getenv("KASTEN_DIR")
end

return M
