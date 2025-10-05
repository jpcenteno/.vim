local M = {}

--- Returns the path relative to it's parent directory.
--- @param path string
--- @return string
function M.relative_to_parent_directory(path)
  return "./" .. path:match("([^/\\]+)$")
end

return M
