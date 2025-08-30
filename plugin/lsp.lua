vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP keymaps",
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "x" }, "<F3>", vim.lsp.buf.format, opts)
    vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = event.buf, desc = "Rename symbol" })

    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = 1, float = true }) end)
    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = -1, float = true }) end)
  end,
})


local original_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line duplicate-set-field
vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = {
    { "╭", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╮", "FloatBorder" },
    { "│", "FloatBorder" },
    { "╯", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╰", "FloatBorder" },
    { "│", "FloatBorder" },
  }
  return original_open_floating_preview(contents, syntax, opts, ...)
end
