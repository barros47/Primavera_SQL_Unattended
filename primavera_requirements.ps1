$RootFolder = "C:\Gestao\"
$Folderinstall = "install"
$Folderbackup = "backup"
$Folderprimavera = "primavera"

#Check if the Folders Exist or not
if(Get-ChildItem -Path $RootFolder -ErrorAction Ignore)
{
    Write-Host "Folder Exists"
    #Perform Folder based operation, Count files in folder
    (Get-ChildItem -Path $RootFolder -File | Measure-Object).Count
}
else
{
    Write-Host "Folder Doesn't Exists"

    #PowerShell Create directory if not exists
    New-Item $RootFolder -ItemType Directory
    New-Item $RootFolder$Folderinstall -ItemType Directory
    New-Item $RootFolder$Folderbackup -ItemType Directory
    New-Item $RootFolder$Folderprimavera -ItemType Directory
}

#Check if.Net Framework 3 is Installed
if ((Get-WindowsCapability -Online -Name NetFX3~~~~).State -ne 'Installed')
{
    Write-Host ".Net is not Present"
    
    try
    {
        Add-WindowsCapability –Online -Name NetFx3~~~~ –Source D:\sources\sxs;
    }
    catch
    {
        Write-Warning -Message $_.Exception.Message
    }
}
else
{
    Write-Host ".Net is Present"
}
