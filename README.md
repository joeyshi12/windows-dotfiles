# windows-dotfiles

Dotfiles for my Windows dev environment.

## Getting started

1. Clone the repository.
    ```
    git clone https://github.com/joeyshi12/windows-dotfiles.git .dotfiles
    cd ~/.dotfiles
    ```
2. Install dependencies.
    ```pwsh
    winget import -i packages.json --accept-package-agreements --accept-source-agreements
    ```
3. Enable developer mode in the Windows settings.
4. Create a softlink for the Wezterm config file.
    ```pwsh
    New-Item `
        -ItemType SymbolicLink `
        -Path "$env:HOMEPATH\.wezterm.lua" `
        -Value "$env:HOMEPATH\.dotfiles\.wezterm.lua" | Out-Null
    ```
