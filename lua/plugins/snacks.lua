--- Pick a note by title.
--- @return nil
local function pick_notes()
  local snacks = require("snacks")

  local notes_dir = os.getenv("KASTEN_DIR")
  if not notes_dir or notes_dir == "" then
    vim.notify("Notes directory is unset.", vim.log.levels.ERROR)
    return nil
  end

  local cmd = table.concat({
    "zettelkasten",
    "note",
    "list",
    "--output-format",
    "json",
    "--directory",
    vim.fn.shellescape(notes_dir),
  }, " ")

  local stdout = vim.fn.system(cmd)
  local exit_code = vim.v.shell_error
  if exit_code ~= 0 then
    vim.notify(string.format("Command failed (exit %d): %s", exit_code, cmd), vim.log.levels.ERROR)
    return nil
  end

  local decoded = vim.json.decode(stdout)

  local items = {}
  for _, note in ipairs(decoded) do
    items[#items + 1] = {
      file = note.location,
      text = note.title,
    }
  end

  snacks.picker.pick({
    items = items,
    format = "text", -- Display `"text"` field instead of the filename.
  })
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    input = {},
    notifier = {},
    picker = { ui_select = true },
  },
  keys = {
    {
      "<leader><leader>",
      function()
        Snacks.picker.commands()
      end,
      desc = "Commands",
    },
    {
      "<leader>bb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Find buffers",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.git_files()
      end,
      desc = "Find git files",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep PWD",
    },
    {
      "<leader>no",
      pick_notes,
      desc = "Open note",
    },
  },
}
