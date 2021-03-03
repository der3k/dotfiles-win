# dotfiles-win

```bash
set DOTFILES=C:\home\etc\dotfiles
mklink %USERPROFILE%\.gitconfig %DOTFILES%\git\.gitconfig
mkdir %USERPROFILE%\AppData\Local\nvim
mklink %USERPROFILE%\AppData\Local\nvim\init.vim %DOTFILES%\nvim\init.vim
```