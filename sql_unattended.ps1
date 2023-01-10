Start-Process powershell.exe -Verb RunAs "-command NetSh Advfirewall set allprofiles state on";

md c:\Gestao;
md c:\Gestao\install;
md c:\Gestao\backup;
md c:\Gestao\primavera;

Copy-Item "ConfigurationFile.ini" "c:\Gestao\install\";

Install-WindowsFeature NET-Framework-Features;

Start-Process -FilePath “C:\SCCM\SQLEXPRADV_x64_ENU\SETUP.exe /CONFIGURATIONFILE=C:\Gestao\install\ConfigurationFile.ini /IAcceptSQLServerLicenseTerms”