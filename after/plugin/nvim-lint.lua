local lint = require("lint")

lint.linters_by_ft = {
    sh = { 'shellcheck' },
    bash = { 'shellcheck' },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

-- Trigger linting on save
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
        lint.try_lint()
        -- lint.try_lint("cspell") -- Spellcheck everywhere.
    end,
})
