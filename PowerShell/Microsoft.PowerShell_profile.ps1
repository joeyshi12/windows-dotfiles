New-Alias -Name "v" "nvim"
New-Alias -Name "lfcd" "$Home\.dotfiles\PowerShell\lfcd.ps1"
Set-PSReadlineOption -EditMode vi

oh-my-posh init pwsh --config "$Home\AppData\Local\Programs\oh-my-posh\themes\powerlevel10k_lean.omp.json" | Invoke-Expression
