return {
  "jiangmiao/auto-pairs",
  init = function()
    -- Had to unset this because the plugin was raising errors when trying to
    -- hook into _Snacks.nvim_ picker buffers. I can't recall the exact error
    -- message, but it had something to do with mappings without `rhs`. While
    -- invalid on vim, mappings whithout `rhs` are possible in neovim because
    -- of Lua callbacks.
    --
    -- This "Fixes" it in the sense that the error disspears at the expense of
    -- disabling the <CR> feature. For a better solution try:
    --
    -- - Disabling this plugin on picker buffers (I don't want auto pairs on a
    --   searchbox).
    -- - Fork/PR the plugin to be compatible with neovim.
    vim.g.AutoPairsMapCR = 0
  end,
}
