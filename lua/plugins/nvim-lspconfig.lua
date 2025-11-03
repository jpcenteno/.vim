-- RTFM @ `:help lspconfig-all`.

---Configuration wrapper for LSP servers. Inject
---@param name string Name of the language server to configure and enable.
---@param opts table? Configuration table for the language server.
local function setup_lsp(name, opts)
  opts = opts or {}
  -- FIXME do I need to mark cmp as a dependency? It's declared on it's own file
  -- as it's usage is independent of nvim-lspconfig.
  opts.capabilities = require("cmp_nvim_lsp").default_capabilities()

  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end

return {
  "neovim/nvim-lspconfig",
  dependencies = {},
  config = function()
    local lspconfig = require("lspconfig")

    setup_lsp("clangd")

    setup_lsp("clojure_lsp")

    setup_lsp("deno", {
      -- Prevent attachment into a Node project.
      -- RTFM @ https://docs.deno.com/runtime/manual/getting_started/setup_your_environment#neovim-06-using-the-built-in-language-server
      root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
    })

    setup_lsp("elixirls", { cmd = { "elixir-ls" } })

    setup_lsp("gopls")

    setup_lsp("lua_ls", {
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if
            path ~= vim.fn.stdpath("config")
            ---@diagnostic disable-next-line: undefined-field
            and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
          then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using (most
            -- likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
            -- Tell the language server how to find Lua modules same way as Neovim
            -- (see `:h lua-module-load`)
            path = {
              "lua/?.lua",
              "lua/?/init.lua",
            },
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              -- Depending on the usage, you might want to add additional paths
              -- here.
              -- '${3rd}/luv/library'
              -- '${3rd}/busted/library'
            },
            -- Or pull in all of 'runtimepath'.
            -- NOTE: this is a lot slower and will cause issues when working on
            -- your own configuration.
            -- See https://github.com/neovim/nvim-lspconfig/issues/3189
            -- library = {
            --   vim.api.nvim_get_runtime_file('', true),
            -- }
          },
        })
      end,
      settings = {
        Lua = {},
      },
    })

    setup_lsp("nil_ls")

    setup_lsp("pyright")

    setup_lsp("rust_analyzer")

    setup_lsp("tailwindcss-language-server")

    setup_lsp("ts_ls", {
      -- Prevent attachment into a Deno project.
      -- See https://docs.deno.com/runtime/manual/getting_started/setup_your_environment#neovim-06-using-the-built-in-language-server
      root_dir = lspconfig.util.root_pattern("package.json"),
      single_file_support = false,
    })

    setup_lsp("vim-language-server")
  end,
}
