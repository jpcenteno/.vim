local M = {}

--- Mutates `dst` by appending the elements from `src` in order. Ignores
--- non-numeric keys.
---
--- @param dst any[]
--- @param src any[]
M.extend = function(dst, src)
  for _, value in ipairs(src) do
    dst[#dst + 1] = value
  end
end

--- Returns a new list (no mutations) equal to the concatenation of `list1` and
--- `list2`. Ignores non-numeric keys.
---
--- @param list1 any[]
--- @param list2 any[]
--- @return any[]
M.concatenation = function(list1, list2)
  local out = {}
  M.extend(out, list1)
  M.extend(out, list2)
  return out
end

return M
