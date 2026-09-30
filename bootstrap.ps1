New-Item `
    -ItemType Junction `
    -Path "$env:HOMEPATH\AppData\Roaming\nushell" `
    -Value "$env:HOMEPATH\.dotfiles\AppData\Roaming\nushell" | Out-Null

New-Item `
    -ItemType SymbolicLink `
    -Path "$env:HOMEPATH\.wezterm.lua" `
    -Value "$env:HOMEPATH\.dotfiles\.wezterm.lua" | Out-Null
