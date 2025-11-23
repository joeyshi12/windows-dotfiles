New-Alias -Name "v" "nvim"
New-Alias -Name "lf" "$Home\.dotfiles\PowerShell\lfcd.ps1"
Set-PSReadlineOption -EditMode vi

oh-my-posh init pwsh | Invoke-Expression
