@ECHO OFF
title ---] Windivert from GoodbyeDPI downloading... [---
color f1
PUSHD "%~dp0"

IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (set "os_arch=64")
IF "%PROCESSOR_ARCHITECTURE%"=="x86" (set "os_arch=32")
IF DEFINED PROCESSOR_ARCHITEW6432 (set "os_arch=64")

if %os_arch%==32 (
color f2
echo Windows x86 detected! Nothing to do.
echo Press any key for exit
pause > nul
goto :EOF
)

if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

for /f "skip=3 tokens=1,2,* delims=: " %%i in ('sc query "GoodbyeDPI"') do (
 if %%j==4 (
 color fc
 echo GoodbyeDPI service is running!
 echo Stopping service...
 net stop GoodbyeDPI > nul
 echo Deleting service...
 sc delete GoodbyeDPI > nul
 ping -n 4 127.0.0.1 > nul
 )
rem exit
)
for /f "skip=3 tokens=1,2,* delims=: " %%i in ('sc query "zapret"') do (
 if %%j==4 (
 color fc
 echo Zapret service is running!
 echo Stopping service...
 net stop zapret > nul
 )
rem exit
)
for /f "skip=3 tokens=1,2,* delims=: " %%i in ('sc query "WinDivert"') do (
 if %%j==4 (
 color fc
 echo WinDivert service is running!
 echo Stopping service...
 net stop WinDivert > nul
 ping -n 4 127.0.0.1 > nul
 )
rem exit
)
cls

:CURLDownload
if not exist "%Windir%\System32\curl.exe" (
color fc
echo Error!!! CURL not found. Trying BITS variant...
pause
goto :BITSDownload
)
echo Start downloading release archive from GoodbyeDPI GitHub repo (may take some time).....
curl -sOL https://github.com/ValdikSS/GoodbyeDPI/releases/download/0.2.3rc2/goodbyedpi-0.2.3rc2.zip
ping -n 3 127.0.0.1 > nul
color fA
echo.
echo Downloading archive..... Completed!
goto :Unpacker

:BITSDownload
cls
color f1
echo Preparing.....
bitsadmin /reset > nul
bitsadmin /create progdwnl > nul
bitsadmin /setpriority progdwnl HIGH > nul
bitsadmin /setproxysettings progdwnl NO_PROXY > nul
echo Start downloading release archive from GoodbyeDPI GitHub repo (may take some time).....
bitsadmin /transfer progdwnl https://github.com/ValdikSS/GoodbyeDPI/releases/download/0.2.3rc2/goodbyedpi-0.2.3rc2.zip "%~dp0goodbyedpi-0.2.3rc2.zip" > nul
if not exist "%~dp0goodbyedpi-0.2.3rc2.zip" (
color fc
echo Error!!! Can't download file. Trying default browser variant...
pause
bitsadmin /cancel progdwnl > nul
goto :BROWDownload
)
color f2
echo Downloading archive..... Completed!
goto :Unpacker

:BROWDownload
cls
color f1
echo Start downloading release archive from GoodbyeDPI GitHub repo via default browser.....
start https://github.com/ValdikSS/GoodbyeDPI/releases/download/0.2.3rc2/goodbyedpi-0.2.3rc2.zip
echo Wait for downloading in browser completed, then...
pause
if exist "%~dp0goodbyedpi-0.2.3rc2.zip" (
goto :Unpacker
)
echo.
echo Trying to move goodbyedpi-0.2.3rc2.zip to YTDisBystro folder.....
if exist "%UserProfile%\Downloads\goodbyedpi-0.2.3rc2.zip" (
move /Y "%UserProfile%\Downloads\goodbyedpi-0.2.3rc2.zip" "%~dp0" > nul
color f2
echo Moving... Completed!
goto :Unpacker
)
if not exist "%UserProfile%\Downloads\goodbyedpi-0.2.3rc2.zip" (
color fc
echo Error!!! Non-standart Download folder used. Or antivirus false detect deleted file.
echo [Restore and] Move goodbyedpi-0.2.3rc2.zip to YTDisBystro folder manually then...
pause
)

:Unpacker
cls
color f1
echo.
if not exist "%~dp0goodbyedpi-0.2.3rc2.zip" (
color fc
echo File not found!!! If antivirus deleted file, please restore it then...
pause
)
echo Unpacking archive.....
echo.
unzip -jo "goodbyedpi-0.2.3rc2.zip" goodbyedpi-0.2.3rc2/x86_64/WinDivert.dll goodbyedpi-0.2.3rc2/x86_64/WinDivert%os_arch%.sys
del /F /Q "%~dp0goodbyedpi-0.2.3rc2.zip" > nul
echo.
color f2
echo Unpacking archive..... Completed!
echo.
echo.
echo Changing completed

ping -n 6 127.0.0.1 > nul
