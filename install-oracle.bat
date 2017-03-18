AT > NUL
IF %ERRORLEVEL% NEQ 0 (
    ECHO you are Administrator
    EXIT \B 1
)

REM Install visual studio if not already installed
for /f "delims=" %%i in ('where visualstudio2015') do set output=%%i
IF [%output%] NEQ [] choco install visualstudio2015community

REM Install python if not already installed
for /f "delims=" %%i in ('where python') do set output=%%i
IF [%output%] NEQ [] choco install python2

REM Install NVM if not already installed
for /f "delims=" %%i in ('where nvm') do set output=%%i
IF [%output%] NEQ [] choco install nvm

nvm use 0.12.7

REM needs to unzip and setup instant client directories

unzip -o "oracle-source\windows\instantclient_basic-windows.x64-12.1.0.2.0.zip" -d "instantclient"
unzip -o "oracle-source\windows\instantclient_sdk-windows.x64-12.1.0.2.0.zip" -d "instantclient\sdk"

MD C:\Oracle
MOVE instantclient C:\Oracle

SET PATH=%PATH%;C:\Oracle\instantclient
SET OCI_LIB_DIR=C:\Oracle\instantclient\sdk\lib\msvc
SET OCI_INC_DIR=C:\Oracle\instantclient\sdk\include
