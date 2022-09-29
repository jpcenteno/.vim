# Vim Dotfiles

## Cloning

```sh
cd "${HOME}/.config"
git clone git@github.com:jpcenteno/.vim.git nvim
```

## Configuration files:

| Path                        | Description                              |
|-----------------------------|------------------------------------------|
| `init.vim`                  | Main entrypoint for neovim config.       |
| `ftplugin/<filetype>.vim`   | Local config specific to a file type.    |
| `after/plugin/<plugin>.vim` | Override settings for a specific plugin. |
