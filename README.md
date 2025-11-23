# windows-dotfiles

Dotfiles for my Windows dev environment.

## Getting started

1. Install shell utilities.
    ```pwsh
    winget install JanDeDobbeleer.OhMyPosh gokcehan.lf Neovim.Neovim
    ```
2. Install the meslo nerd font for oh-my-posh.
    ```pwsh
    oh-my-posh font install meslo
    ```
3. Update your terminal font to meslo nerd font.
4. Clone the repository and create softlinks.
    ```pwsh
    git clone https://github.com/joeyshi12/windows-dotfiles.git .dotfiles
    cd ~/.dotfiles
    ./bootstrap.ps1
    ```
