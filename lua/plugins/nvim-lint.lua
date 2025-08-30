return {
  'mfussenegger/nvim-lint',
  config = function()
    local lint = require("lint")

    lint.linters_by_st = {
      sh = { "shellcheck" },
      bash = { "shellcheck" },
    }

    -- Trigger linting on save
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
        -- lint.try_lint("cspell") -- Spellcheck everywhere.
      end,
    })
  end
}
