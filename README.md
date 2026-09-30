# windows-dotfiles

Dotfiles for my Windows dev environment.

## Getting started

1. Install dependencies.
    ```pwsh
    winget import -i packages.json --accept-package-agreements --accept-source-agreements
    ```
2. Enable developer mode in the Windows settings.
3. Clone the repository and create softlinks in Powershell.
    ```pwsh
    git clone https://github.com/joeyshi12/windows-dotfiles.git .dotfiles
    cd ~/.dotfiles
    ./bootstrap.ps1
    ```
