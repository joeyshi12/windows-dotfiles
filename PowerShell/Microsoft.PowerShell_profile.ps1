New-Alias -Name "v" "nvim"
New-Alias -Name "lfcd" "C:\Users\Joey Shi\.dotfiles\PowerShell\lfcd.ps1"
Set-PSReadlineOption -EditMode vi

oh-my-posh init pwsh --config "C:\Users\Joey Shi\AppData\Local\Programs\oh-my-posh\themes\powerlevel10k_lean.omp.json" | Invoke-Expression
