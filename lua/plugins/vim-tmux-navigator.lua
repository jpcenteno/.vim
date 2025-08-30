-- Switch seamlessly between Vim and Tmux splits using `C-{h,j,k,l}`. This
-- plugin requires the same mappings to be set on `tmux.config` so we can use
-- the same keybindings to switch back to vim panes.
--
-- See: `https://github.com/christoomey/vim-tmux-navigator` for instructions on
-- how to set that up on Tmux.
return {
  "christoomey/vim-tmux-navigator",
}
