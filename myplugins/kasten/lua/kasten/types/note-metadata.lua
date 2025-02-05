--- @class Kasten.NoteMetadata
--- @field absolutePath string The note's absolute path.
--- @field relativePath string The note's filename.
--- @field title string The note's title.
local NoteMetadata = {}

--- Creates a new NoteMetadata instance.
--- @param tbl {absolutePath: string, relativePath: string, title: string}
--- @return Kasten.NoteMetadata
function NoteMetadata.new(tbl)
  local self = setmetatable({}, NoteMetadata)
  self.absolutePath = tbl.absolutePath
  self.relativePath = tbl.relativePath
  self.title = tbl.title
  return self
end

return NoteMetadata
