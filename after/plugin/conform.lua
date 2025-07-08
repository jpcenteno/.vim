require("conform").setup({
  formatters_by_ft = {
    python = { "isort", "black" }, -- Will run `isort`, then `black`
  },
  format_on_save = {
    -- Attempt to use the LSP formatter if no formatters are specified for the buffer's file-type.
    lsp_fallback = true,
    -- Block until formatting is done.
    async = false,
    -- Autoformatter timeout. I had to set a long timeout because some
    -- formatters like `black` spend more time on their first usage.
    timeout_ms = 5000,
  },
})
