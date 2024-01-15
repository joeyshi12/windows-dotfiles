function Create-Junction {
    Param
    (
         [Parameter(Mandatory=$true)]
         [string] $SourcePath,
         [Parameter(Mandatory=$true)]
         [string] $TargetPath
    )
    Write-Host "Creating symbolic link in $TargetPath"
    if (Test-Path $TargetPath) {
        Remove-Item $TargetPath
    }
    New-Item `
        -ItemType Junction `
        -Path $TargetPath `
        -Value $SourcePath | Out-Null
}

Get-ChildItem -Path "AppData\Local" -Directory | ForEach-Object {
    $ConfigName = $($_.Name)
    Create-Junction `
        -SourcePath "$env:HOMEPATH\.dotfiles\AppData\Local\$ConfigName" `
        -TargetPath "$env:HOMEPATH\AppData\Local\$ConfigName"
}

$PowershellPath = $(Split-Path $PROFILE)
Create-Junction `
    -SourcePath "$env:HOMEPATH\.dotfiles\Powershell" `
    -TargetPath $PowershellPath
