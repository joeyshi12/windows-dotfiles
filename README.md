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
4. Create softlinks.
    ```pwsh
    .\bootstrap.ps1
    ```
