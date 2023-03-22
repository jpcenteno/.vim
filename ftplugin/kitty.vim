setlocal commentstring=#\ %s

" Reloads Kitty config on write.
autocmd bufwritepost ~/.config/kitty/kitty.conf :silent !pkill -SIGUSR1 kitty
