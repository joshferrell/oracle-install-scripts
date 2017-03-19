@echo off

NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO You are not an administrator, Please run the program again as an admin.
    PAUSE
    EXIT \B 1
)

SET visualstudio=false
ECHO Checking if visual studio 2015 is installed

reg query HKLM\SOFTWARE\Classes\Installer\Dependencies\{050d4fc8-5d48-4b8f-8972-47c82c46020f}
IF %ERRORLEVEL% NEQ 0 (
    SET visualstudio=true
)

reg query HKLM\SOFTWARE\Classes\Installer\Dependencies\{f65db027-aff3-4070-886a-0d87064aabb1}
IF %ERRORLEVEL% NEQ 0 (
    SET visualstudio=true
)

IF "%visualstudio%" == true (
    ECHO Installing visual studio code ...
    choco install -y visualstudio2013community
)

ECHO Checking if python is installed
python --version 2>NUL
if errorlevel 1 (
    ECHO Installing python 2.x ...
    choco install -y python2
)

ECHO Checking if node version manager is installed
nvm > NUL
if errorlevel 1 (
    ECHO Installing Node Version Manager for Windows
    choco install -y nvm
)

ECHO Checking if 7zip is installed
7z > NUL
if errorlevel 1 (
    ECHO Installing 7zip
    choco install -y 7zip
    SETX PATH "C:\Program Files (x86)\7-Zip;%path%;"
)

SETX PATH "C:\Oracle\instantclient;%path%;"

ECHO extracting instantclient
7z x -aoa -r -tzip instantclient-basic-windows.x64-12.1.0.2.0.zip
7z x -aoa -r -tzip instantclient-sdk-windows.x64-12.1.0.2.0.zip -osdk
RENAME instantclient_12_1 instantclient
MOVE sdk instantclient

MD C:\Oracle
MOVE instantclient C:\Oracle

SETX OCI_LIB_DIR C:\Oracle\instantclient\sdk\lib\msvc
SETX OCI_INC_DIR C:\Oracle\instantclient\sdk\include

ECHO Changing current node version to 0.12.7; If you are using a newer version of node for a different project, use `nvm use latest`
start cmd /k (
    nvm on
    nvm install 0.12.7
    nvm use 0.12.7
)
