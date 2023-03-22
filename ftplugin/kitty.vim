setlocal commentstring=#\ %s

" Reloads Kitty config on write.
autocmd bufwritepost ~/.config/kitty/kitty.conf :silent !kill -SIGUSR1 $(pgrep kitty)
