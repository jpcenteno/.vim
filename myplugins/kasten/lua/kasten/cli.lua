-- [[
-- This module provides a wrapper around the Kasten CLI.
-- ]]

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
--- @class NoteNewResult
--- @field absolutePath string The absolute path of the new note.
--- @field relativePath string The filename of the new note.
--- @field title string The parsed title of the new note.
---
--- @param arguments NoteNewArguments
--- @return NoteNewResult
M.note_new = function(arguments)
  local command = { "note", "new", "--json" }

  if arguments.directory then
    table.insert(command, "--directory")
    table.insert(command, vim.fn.shellescape(arguments.directory))
  end

  table.insert(command, "-t")
  table.insert(command, vim.fn.shellescape(arguments.title))

  return M._run_command(command)
end

--- Runs the `note list` subcommand.
---
--- @class NoteListArguments
--- @field directory string | nil
---
--- @class NoteListResultItem
--- @field absolutePath string The absolute path of the new note.
--- @field relativePath string The filename of the new note.
--- @field title string The parsed title of the new note.
---
--- @param arguments NoteListArguments
--- @return NoteListResultItem[]
M.note_list = function(arguments)
  local command = { "note", "list", "--json" }

  if arguments.directory then
    table.insert(command, "--directory")
    table.insert(command, vim.fn.shellescape(arguments.directory))
  end

  return M._run_command(command)
end

return M
