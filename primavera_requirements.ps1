param(
    [string]$RootFolder = "C:\Gestao\",
    [string]$Folderinstall = "install",
    [string]$Folderbackup = "backup",
    [string]$Folderprimavera = "primavera"
)

# Check if the folders exist
if (Test-Path $RootFolder) {
    Write-Host "Root folder exists"
} else {
    Write-Host "Root folder does not exist"
    try {
        New-Item $RootFolder -ItemType Directory | Out-Null
        New-Item "$RootFolder$Folderinstall" -ItemType Directory | Out-Null
        New-Item "$RootFolder$Folderbackup" -ItemType Directory | Out-Null
        New-Item "$RootFolder$Folderprimavera" -ItemType Directory | Out-Null
        Write-Host "Directories created successfully"
    } catch {
        Write-Host "Error creating directories: $($_.Exception.Message)"
    }
}

# Check if .NET Framework 3 is installed
if ((Get-WindowsCapability -Online -Name NetFX3~~~~).State -ne 'Installed') {
    Write-Host ".NET Framework 3.5 is not installed"
    try {
        Add-WindowsCapability –Online -Name NetFx3~~~~ –Source D:\sources\sxs;
        Write-Host ".NET Framework 3.5 installed successfully"
    } catch {
        Write-Warning -Message "Error installing .NET Framework 3.5: $($_.Exception.Message)"
    }
} else {
    Write-Host ".NET Framework 3.5 is installed"
}
