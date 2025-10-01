--- Represents a position in the buffer.
--- @class (exact) Position
--- @field row integer A positive integer.
--- @field column integer A positive integer.
local Position = {}

--- Instantiates a new mark.
--- @param o { row: integer, column: integer }
--- @return Position
function Position:new(o)
  assert(type(o.column) == "number", "Field `column` must be a `number`")
  assert(o.column % 1 == 0, "Field `column` must be an integer")
  assert(0 < o.column, "Field `column` must be positive")
  assert(type(o.row) == "number", "Field `row` must be a `number`")
  assert(o.row % 1 == 0, "Field `row` must be an integer")
  assert(0 < o.row, "Field `row` must be positive")

  setmetatable(o, self)
  return o
end

--- Constructs a `Position` from a Vim `getpos` expression.
---
--- @param expr string An expression accepted by `vim.fn.getpos`.
--- @return Position
function Position:getpos(expr)
  local _, row, column, _ = unpack(vim.fn.getpos(expr))
  return Position:new({ row = row, column = column })
end

--- Returns true if and only if this `Position` comes before the other
--- `Position`.
---
--- @param other Position
--- @return boolean
function Position:__lt(other)
  return self.row < other.row or (self.row == other.row and self.column < other.column)
end
