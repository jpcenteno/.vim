--- @alias VisualMode
---| "v"   # Character-wise Visual mode.
---| "V"   # Line-wise Visual mode.
---| "\22" # Block-range Visual mode. "\22" is the escaped form of Ctrl-V

--- @class (exact) VisualRange
--- @field mode VisualMode
--- @field from zettelkasten.utils.nvim.position.Position
--- @field to zettelkasten.utils.nvim.position.Position
local VisualRange = {}

--- Creates a new VisualRange.
--- @param mode VisualMode
--- @param from zettelkasten.utils.nvim.position.Position
--- @param to zettelkasten.utils.nvim.position.Position
--- @return VisualRange
function VisualRange:new(mode, from, to)
  -- normalize row/col order
  if to < from then
    from, to = to, from
  end

  local o = { mode = mode, from = from, to = to }
  setmetatable(o, { __index = self })
  return o
end

--- Returns true if the `VisualRange` does not span across multiple lines.
--- @return boolean
function VisualRange:is_single_line()
  return self.from.row == self.to.row
end

return VisualRange
