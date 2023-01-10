Start-Process powershell.exe -Verb RunAs "-command NetSh Advfirewall set allprofiles state off";

md c:\Gestao;
md c:\Gestao\install;
md c:\Gestao\backup;
md c:\Gestao\primavera;

Copy-Item -Path  "C:\SCCM\ConfigurationFile.ini" "c:\Gestao\install\";

Add-WindowsCapability –Online -Name NetFx3~~~~ –Source D:\sources\sxs;

Start-Process -FilePath C:\SCCM\sqlexpress2017\SETUP.exe  -Verb RunAs  /CONFIGURATIONFILE="C:\Gestao\install\ConfigurationFile.ini"
