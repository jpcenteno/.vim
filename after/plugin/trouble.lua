local trouble = require("trouble")

trouble.setup({
    -- Don't preview by default (press `P` to change this behavior)
    auto_preview = false,
    padding = false, -- Don't add a blank line on top.
    icons = false,   -- Don't use cringe devicons.
    signs = {
        error = "ERRR",
        warning = "WARN",
        hint = "HINT",
        information = "INFO",
    },
    fold_open = "▼",
    fold_closed = "▶",
    indent_lines = false -- Declutter indent line.
})

-- Make the fold triangles the same color as the file name.
vim.api.nvim_set_hl(0, 'TroubleFoldIcon', { link = "TroubleFile" })

vim.diagnostic.config({
    -- Disable inline LSP messages since Trouble.vim makes them redundant.
    virtual_text = false
})
