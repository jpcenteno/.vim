local NoteMetadata = require("kasten.types.note-metadata")

local M = {}

--- Helper function that runs the actual command.
--- @param command_parts string[]
--- @return table result
M._run_command = function(command_parts)
  local command = "kasten-cli " .. table.concat(command_parts, " ")

  local handle = io.popen(command, "r")
  if not handle then
    error("Failed to run command: `" .. command .. "`")
  end

  local stdout = handle:read("*a")
  handle:close()

  local success, decoded = pcall(vim.json.decode, stdout)
  if not success then
    error("Failed to parse output from command: `" .. command .. "`")
  end

  return decoded
end


--- Runs the `note new` subcommand to create a new note.
---
--- @class NoteNewArguments
--- @field directory string | nil
--- @field title string
---
--- @param arguments NoteNewArguments
--- @return Kasten.NoteMetadata
M.note_new = function(arguments)
  local command = { "note", "new", "--json" }

  if arguments.directory then
    table.insert(command, "--directory")
    table.insert(command, vim.fn.shellescape(arguments.directory))
  end

  table.insert(command, "-t")
  table.insert(command, vim.fn.shellescape(arguments.title))

  return NoteMetadata.new(M._run_command(command))
end

--- Runs the `note list` subcommand.
---
--- @class NoteListArguments
--- @field directory string | nil
---
--- @param arguments NoteListArguments
--- @return Kasten.NoteMetadata[]
M.note_list = function(arguments)
  local command = { "note", "list", "--json" }

  if arguments.directory then
    table.insert(command, "--directory")
    table.insert(command, vim.fn.shellescape(arguments.directory))
  end

  local note_metadatas = {}
  for _, tbl in ipairs(M._run_command(command)) do
    note_metadatas[#note_metadatas + 1] = NoteMetadata.new(tbl)
  end
  return note_metadatas
end

return M
