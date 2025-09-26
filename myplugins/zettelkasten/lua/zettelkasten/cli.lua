local table_utils = require("zettelkasten.utils.table")

local M = {}

--- Executes a `zettelkasten` subcommand and returns the STDOUT. Throws error
--- when the child process exits with non-zero exit code.
---
--- @param args any
--- @return string?
local function execute(args)
  local cmd = table_utils.concatenation({ "zettelkasten" }, args)
  local out = vim.system(cmd, { text = true }):wait()

  if out.code ~= 0 then
    error("Command `" .. table.concat(cmd, " ") .. "` failed\n" .. vim.inspect(out), vim.log.levels.ERROR)
  end

  -- Now that we know the command succeed, we can discard other data from `out`.
  return out.stdout
end

--- Executes a `zettelkasten` subcommand and parses it's JSON output.
---
--- @param args string[]
--- @return any
local function execute_json(args)
  local args_json = table_utils.concatenation(args, { "--output-format", "json" })
  local stdout = execute(args_json)

  return vim.json.decode(stdout or "", { luanil = { object = true, array = true } })
end

--- Executes the `note new` subcommand from the `zettelkasten` CLI application
--- and returns it's output record.
---
--- @param title string
M.note_new = function(title)
  return execute_json({ "note", "new", "--title", title })
end

M.note_list = function()
  return execute_json({ "note", "list" })
end

return M
