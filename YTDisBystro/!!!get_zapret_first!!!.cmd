@ECHO OFF
call win_check.cmd

:startall
title ----] zapret downloading... [----
color f1
PUSHD "%~dp0"

:: Enter zapret version here ::
set "zapret_ver=v71"

IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (set "os_arch=64")
IF "%PROCESSOR_ARCHITECTURE%"=="x86" (set "os_arch=32")
IF DEFINED PROCESSOR_ARCHITEW6432 (set "os_arch=64")

cls
if exist "%~dp0zapret-%zapret_ver%.zip" (
goto :Unpacker
)
if exist "%~dp0winws.exe" if exist "%~dp0WinDivert%os_arch%.sys" (
goto :ZapretStart
)
if not exist "%~dp0winws.exe" if not exist "%~dp0WinDivert%os_arch%.sys" (
goto :CURLDownload
)
goto :EOF

:CURLDownload
if not exist "%Windir%\System32\curl.exe" (
color fc
echo Error!!! CURL not found. Trying BITS variant...
pause
goto :BITSDownload
)
echo Start downloading release archive %zapret_ver% from Zapret GitHub repo (may take some time).....
curl -sOL https://github.com/bol-van/zapret/releases/download/%zapret_ver%/zapret-%zapret_ver%.zip
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
echo Start downloading release archive %zapret_ver% from Zapret GitHub repo (may take some time).....
bitsadmin /transfer progdwnl https://github.com/bol-van/zapret/releases/download/%zapret_ver%/zapret-%zapret_ver%.zip "%~dp0zapret-%zapret_ver%.zip" > nul
if not exist "%~dp0zapret-%zapret_ver%.zip" (
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
echo Start downloading release archive %zapret_ver% from Zapret GitHub repo via default browser.....
start https://github.com/bol-van/zapret/releases/download/%zapret_ver%/zapret-%zapret_ver%.zip
echo Wait for downloading in browser completed, then...
pause
if exist "%~dp0zapret-%zapret_ver%.zip" (
goto :Unpacker
)
echo.
echo Trying to move zapret-%zapret_ver%.zip to YTDisBystro folder.....
if exist "%UserProfile%\Downloads\zapret-%zapret_ver%.zip" (
move /Y "%UserProfile%\Downloads\zapret-%zapret_ver%.zip" "%~dp0" > nul
color f2
echo Moving... Completed!
goto :Unpacker
)
if not exist "%UserProfile%\Downloads\zapret-%zapret_ver%.zip" (
color fc
echo Error!!! Non-standart Download folder used. Or antivirus false detect deleted file.
echo [Restore and] Move zapret-%zapret_ver%.zip to YTDisBystro folder manually then...
pause
)

:Unpacker
cls
color f1
echo.
if not exist "%~dp0zapret-%zapret_ver%.zip" (
color fc
echo File not found!!! If antivirus deleted file, please restore it then...
pause
)
echo Unpacking archive.....
echo.
unzip -jo "zapret-%zapret_ver%.zip" zapret-%zapret_ver%/binaries/win%os_arch%/winws.exe zapret-%zapret_ver%/binaries/win%os_arch%/WinDivert.dll zapret-%zapret_ver%/binaries/win%os_arch%/WinDivert%os_arch%.sys zapret-%zapret_ver%/binaries/win%os_arch%/cygwin1.dll
del /F /Q "%~dp0zapret-%zapret_ver%.zip" > nul
echo.
color f2
echo Unpacking archive..... Completed!
echo.
echo.
echo Download completed
ping -n 10 127.0.0.1 > nul


:ZapretStart
exit
