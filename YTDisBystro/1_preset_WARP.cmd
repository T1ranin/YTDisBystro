@ECHO OFF
PUSHD "%~dp0"
color f1
goto :Preparing
:Zapusk

:: Здесь нужно указать IP вашей конечной точки [endpoint] WARP для маскировки трафика ::
set YTDB_WARP_IP=162.159.198.1,162.159.198.2

:: Здесь нужно указать порт вашей конечной точки [endpoint] WARP для маскировки трафика ::
set YTDB_WARP_PORT=443

:: Здесь можно включить дебаг-лог убрав rem и выключить, добавив rem ::
rem set YTDB_prog_log=--debug=@%~dp0log_debug.txt

start "---] zapret: WARP [---" "%~dp0winws.exe" %YTDB_prog_log% ^
--wf-tcp=80,443 --wf-udp=%YTDB_WARP_PORT% ^
--filter-tcp=80,443 --hostlist="%~dp0lists\netrogat.txt" --new ^
--filter-tcp=80 --hostlist-domains=cloudflareportal.com,cloudflareok.com,cloudflareclient.com,cloudflarecp.com --dpi-desync=fake,multisplit --dpi-desync-split-seqovl=2 --dpi-desync-split-pos=sld+1 --dpi-desync-fake-http="%~dp0fake\http_fake_MS.bin" --dpi-desync-fooling=md5sig --dup=2 --dup-fooling=md5sig --dup-cutoff=n3 --new ^
--filter-tcp=443 --hostlist-domains=cloudflare-ech.com,cloudflare-dns.com,cloudflareok.com,cloudflareclient.com,cloudflareportal.com,cloudflarecp.com --dpi-desync=multisplit --dpi-desync-split-seqovl=211 --dpi-desync-split-seqovl-pattern="%~dp0fake\tls_clienthello_5.bin" --dup=2 --dup-cutoff=n3 --new ^
--filter-udp=%YTDB_WARP_PORT% --ipset-ip=%YTDB_WARP_IP% --dpi-desync=fake --dpi-desync-fake-quic="%~dp0fake\quic_7.bin" --dpi-desync-repeats=2 --dpi-desync-autottl --dpi-desync-cutoff=n5 --dup=2 --dup-autottl --dup-cutoff=n5 --new ^
--filter-tcp=80 --hostlist-auto="%~dp0lists\autohostlist.txt" --hostlist-exclude="%~dp0lists\netrogat.txt" --dpi-desync=fake,multisplit --dpi-desync-split-seqovl=2 --dpi-desync-split-pos=sld+1 --dpi-desync-fake-http=0x0E0E0F0E --dpi-desync-fooling=md5sig --new ^
--filter-tcp=443 --hostlist-auto="%~dp0lists\autohostlist.txt" --hostlist-exclude="%~dp0lists\netrogat.txt" --dpi-desync=fake,fakedsplit --dpi-desync-split-pos=1 --dpi-desync-fake-tls="%~dp0fake\tls_clienthello_9.bin" --dpi-desync-fooling=badseq --dpi-desync-autottl

goto :EOF

:Preparing
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
del /F /Q "%~dp0logfile.log" > nul
cls

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
ipconfig /flushdns > nul
goto :Zapusk
