-- FIXME should I unmap this way or cal `:unmap <lhs>`?
local function unmap(modes, key)
  vim.keymap.set(modes, key, "<Nop>", { remap = false, silent = true })
end

local M = {}

M.setup = function()
  vim.g.mapleader = " "
  vim.g.maplocalleader = ","

  -- Ensure nothing is mapped to leader keys to prevent triggering an arbitrary
  -- event on timeout.
  unmap("n", vim.g.mapleader)
  unmap("n", vim.g.maplocalleader)

  -- Shorthand for `:` to save me a shift.
  vim.keymap.set({ "n", "v" }, ";", ":", { remap = false, silent = true, desc = "Enter command-line mode" })

  vim.keymap.set({ "n", "v" }, "Q", "@q", { remap = false, silent = true, desc = "Execute macro @q" })

  vim.keymap.set("n", "Y", "y$", { remap = false, silent = true, desc = "Yank to end of line" })

  -- Use this "prefix" to use the clipboard on the next operation.
  vim.keymap.set({ "n", "v" }, "<C-c>", '"+', { remap = false, silent = true, desc = "Use clipboard register" })
end

return M
