# dotfiles-win

```bash
set DOTFILES=C:\home\etc\dotfiles

mklink %USERPROFILE%\.gitconfig %DOTFILES%\git\.gitconfig

mkdir %USERPROFILE%\AppData\Local\nvim
mklink %USERPROFILE%\AppData\Local\nvim\init.vim %DOTFILES%\nvim\init.vim
# in powershell
md ~\AppData\Local\nvim\autoload
$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile(
  $uri,
  $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
    "~\AppData\Local\nvim\autoload\plug.vim"
  )
) 

mkdir %USERPROFILE%\.vifm
mklink %USERPROFILE%\.vifm\vifmrc %DOTFILES%\vifm\vifmrc
```