# For install Primavera SQL database unattended.


# Primavera SQL Database Installation unattended

Primavera SQL Database Installation unattended is a batch file that does not require user input for Primavera Databases parameters as password, collation and instance name 

## Installation

Use the windows10_template.bat to create default folders, copy sql configurationfile, install SQL and SSMS.


## Usage

#Check and request Administrative Privileges.
  
    REM  --> Check for permissions
    >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

    REM --> If error flag set, we do not have admin.
    if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
    ) else ( goto gotAdmin )

    :UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

    :gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"

#Disable Windows Firewall on all profiles

    NetSh Advfirewall set allprofiles state off

#Create Primavera folders on C:\ Drive

    md c:\Gestao
    md c:\Gestao\install
    md c:\Gestao\backup
    md c:\Gestao\primavera

#Copy configuration file with Primavera required parameters to specific folder.

    START /WAIT xcopy "ConfigurationFile.ini" "c:\Gestao\install\"

#Enable Netframework Feature.

    dism /online /enable-feature /featurename:NetFx3 /all

#Start SQL Setup with configuration file.

    START /WAIT C:\INCENTEA\SQLEXPRADV_x64_ENU\SETUP.exe /CONFIGURATIONFILE=C:\Gestao\install\ConfigurationFile.ini /IAcceptSQLServerLicenseTerms

#Install SQL Management Studio.

    START /WAIT SSMS-Setup-PTB.exe /install /quiet /passive /norestart

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

(https://https://itdabanda.blogspot.com/)
