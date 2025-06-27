@echo off
chcp 866 > nul
title ---] zapret - services cleaning... [---
color f1
pushd "%~dp0"

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

del /F /Q /S "%~dp0logfile.log" > nul
echo.
call :srvdel zapret
rem call :srvdel zapret2
goto :eof

:srvdel
net stop %1
sc delete %1
net stop Windivert
sc delete Windivert
ipconfig /flushdns > nul

tasklist /fi "IMAGENAME eq RBTray.exe" | find /i "RBTray.exe"
if errorlevel 0 (
TASKKILL /F /IM RBTray.exe /T
regsvr32 /u /s "%~dp0tray\RBHook.dll"
)
echo .
reg delete HKCU\Environment /f /v YTDB_AUTOTTL_OFF > nul
reg delete HKCU\Environment /f /v YTDB_IPV6_OFF > nul
reg delete HKCU\Environment /f /v YTDB_TTL_OFF > nul
reg delete HKCU\Environment /f /v YTDB_TTL_NUM > nul
reg delete HKCU\Environment /f /v YTDB_TLS_MAIN_SET > nul
reg delete HKCU\Environment /f /v YTDB_TLS_MAIN_Custom > nul

reg delete HKCU\Environment /f /v YTDB_QUIC_MAIN_SET > nul
reg delete HKCU\Environment /f /v YTDB_QUIC_MAIN_Custom > nul

reg delete HKCU\Environment /f /v YTDB_TLS_MAIN2_SET > nul
reg delete HKCU\Environment /f /v YTDB_TLS_MAIN2_Custom > nul

reg delete HKCU\Environment /f /v YTDB_ZAPRET_LOG_ON > nul
color fa
echo.
echo Очистка завершена...
pause
