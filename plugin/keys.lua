vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Shorthand for `:` to save me a shift.
vim.keymap.set({ "n", "v" }, ";", ":", { remap = false, silent = true, desc = "Enter command-line mode" })

vim.keymap.set({ "n", "v" }, "Q", "@q", { remap = false, silent = true, desc = "Execute macro @q" })

vim.keymap.set("n", "Y", "y$", { remap = false, silent = true, desc = "Yank to end of line" })

-- Use this "prefix" to use the clipboard on the next operation.
vim.keymap.set({ "n", "v" }, "<C-c>", '"+', { remap = false, silent = true, desc = "Use clipboard register" })
