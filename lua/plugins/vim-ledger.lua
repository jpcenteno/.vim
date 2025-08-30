vim.g.ledger_is_hledger = false

vim.g.ledger_date_format = "%Y-%m-%d"

-- Align buffer before saving.
-- au BufWritePre <buffer> :LedgerAlignBuffer

-- vim.g.ledger_align_at = 60
-- vim.g.ledger_align_commodity = 0
-- vim.g.ledger_default_commodity = ''

return {
  "ledger/vim-ledger",
  ft = "ledger",
}
