<#
.SYNOPSIS
    Check if the requirements for installing Primavera software are met.

.PARAMETER RootFolder
    The root folder where the Primavera software will be installed. Default value is "C:\Gestao\".

.PARAMETER Folderinstall
    The subfolder where the Primavera installer will be stored. Default value is "install".

.PARAMETER Folderbackup
    The subfolder where the Primavera backup files will be stored. Default value is "backup".

.PARAMETER Folderprimavera
    The subfolder where the Primavera software will be installed. Default value is "primavera".
#>

[CmdletBinding()]
param(
    [string]$RootFolder = "C:\Gestao\",
    [string]$Folderinstall = "install",
    [string]$Folderbackup = "backup",
    [string]$Folderprimavera = "primavera"
)

# Check if the root folder exists
if (Test-Path $RootFolder) {
    Write-Output "Root folder exists: $RootFolder"
} else {
    Write-Output "Root folder does not exist: $RootFolder"
    try {
        New-Item $RootFolder -ItemType Directory | Out-Null
        New-Item "$RootFolder$Folderinstall" -ItemType Directory | Out-Null
        New-Item "$RootFolder$Folderbackup" -ItemType Directory | Out-Null
        New-Item "$RootFolder$Folderprimavera" -ItemType Directory | Out-Null
        Write-Output "Directories created successfully"
    } catch {
        Write-Warning "Error creating directories: $($_.Exception.Message)"
    }
}

# Check if .NET Framework 3 is installed
if ((Get-WindowsCapability -Online -Name NetFX3~~~~).State -ne 'Installed') {
    Write-Output ".NET Framework 3.5 is not installed"
    try {
        Add-WindowsCapability –Online -Name NetFx3~~~~ –Source D:\sources\sxs;
        Write-Output ".NET Framework 3.5 installed successfully"
    } catch {
        Write-Warning "Error installing .NET Framework 3.5: $($_.Exception.Message)"
    }
} else {
    Write-Output ".NET Framework 3.5 is installed"
}
