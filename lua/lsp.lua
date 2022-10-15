local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require('lspconfig')
local trouble = require("trouble")

mason.setup()

-- What value is `mason-lspconfig` providing here?
mason_lspconfig.setup({
    ensure_installed = { "rust_analyzer" },
    automatic_installation = true,
})

local on_attach = function(client, bufnr)
end

local servers = { 'rust_analyzer' }

for _, server in ipairs(servers) do
    lspconfig[server].setup {
        on_attach = on_attach
    }
end

--------------------------------------------------------------------------------
-- Error display                                                              --
--------------------------------------------------------------------------------

-- Configure how inline diagnostics are shown.
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        -- When the same line has more than one LSP message, prioritize them by
        -- severity (i.e. Prioritize an error over an info message).
        severity_sort = true,

        -- Don't display the diagnostic messages inline. Use `Trouble.nvim` to
        -- read them instead.
        virtual_text = false
    }
)

-- Use color-coded `●` symbols for the LSP gutter.
vim.cmd [[
    sign define DiagnosticSignError text=● linehl= texthl=DiagnosticSignError numhl=
    sign define DiagnosticSignWarn text=● linehl= texthl=DiagnosticSignWarn numhl=
    sign define DiagnosticSignInfo text=● linehl= texthl=DiagnosticSignInfo numhl=
    sign define DiagnosticSignHint text=● linehl= texthl=DiagnosticSignHint numhl=
]]

trouble.setup {}

