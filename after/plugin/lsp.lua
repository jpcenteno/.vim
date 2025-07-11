-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║ NeoVim LSP setup:                                                     ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

-- BEFORE WE CONFIGURE ANY LANGUAGE SERVER, we have to patch the default
-- capabilities table from NeoVim's LSP with the extended completion
-- capabilities that `cmp_nvim_lsp` has to offer.
--
-- > Language servers provide different completion results depending on the
-- > capabilities of the client. Neovim's default omnifunc has basic support
-- > for serving completion candidates. nvim-cmp supports more types of
-- > completion candidates, so users must override the capabilities sent to
-- > the server such that it can provide these candidates during a completion
-- > request.
-- >
-- > Source: https://github.com/hrsh7th/cmp-nvim-lsp
local lspconfig_defaults = require("lspconfig").util.default_config
lspconfig_defaults.capabilities =
  vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

-- These configurations only apply to buffers where there is an active language
-- server.
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
  end,
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║ Per-language LSP setup:                                               ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local lspconfig = require("lspconfig")

if vim.fn.executable("clojure-lsp") == 1 then
  lspconfig.clojure_lsp.setup({})
end

lspconfig.elixirls.setup({
  cmd = { "elixir-ls" },
})

if vim.fn.executable("deno") == 1 then -- Skip if deno is not on the dev env.
  lspconfig.denols.setup({
    -- Prevent attachment into a Node project.
    -- See https://docs.deno.com/runtime/manual/getting_started/setup_your_environment#neovim-06-using-the-built-in-language-server
    root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
  })
end

require("lspconfig").gopls.setup({})

lspconfig.nil_ls.setup({
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nixfmt" },
      },
    },
  },
})

-- Python
lspconfig.pyright.setup({})

-- Tailwind
if vim.fn.executable("tailwindcss-language-server") == 1 then
  require("lspconfig").tailwindcss.setup({})
end

require("lspconfig").rust_analyzer.setup({})

-- Typescript
lspconfig.ts_ls.setup({
  -- Prevent attachment into a Deno project.
  -- See https://docs.deno.com/runtime/manual/getting_started/setup_your_environment#neovim-06-using-the-built-in-language-server
  root_dir = lspconfig.util.root_pattern("package.json"),
  single_file_support = false,
})

-- > If you primarily use lua-language-server for Neovim, and want to provide completions, analysis,
-- > and location handling for plugins on runtime path, you can use the following settings.
-- >
-- > -- Source: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
lspconfig.lua_ls.setup({
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        },
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
        -- library = vim.api.nvim_get_runtime_file("", true)
      },
    })
  end,
  settings = {
    Lua = {},
  },
})

-- Vimscript
if vim.fn.executable("vim-language-server") == 1 then
  require("lspconfig").vimls.setup({})
end

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║ Cmp config                                                            ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local cmp = require("cmp")

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ["<CR>"] = cmp.mapping.confirm({ select = false }),

    -- Scroll up and down in the completion documentation
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "async_path" },
  }, {
    { name = "buffer" },
  }),
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║ Floating window borders                                               ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
