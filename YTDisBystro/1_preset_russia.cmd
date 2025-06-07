@ECHO OFF
PUSHD "%~dp0"
color f1
goto :Preparing
:Zapusk

set YTDB_YTQC=--dpi-desync=fake,udplen --dpi-desync-udplen-increment=8 --dpi-desync-udplen-pattern=0x0F0F0E0F --dpi-desync-fake-quic="%~dp0fake\quic_6.bin" --dpi-desync-cutoff=n3 --dpi-desync-repeats=2 --dpi-desync-autottl
set YTDB_WinSZ=43 --hostlist-domains=googlevideo.com --hostlist="%~dp0lists\russia-youtube.txt" --dpi-desync=multisplit --dpi-desync-split-seqovl=1 --dpi-desync-split-pos=sld+1
set YTDB_CFUNBAN=3 --ipset="%~dp0lists\cloudflare-ipset.txt" --ipset-exclude-ip=1.1.1.1, 1.0.0.1, 212.109.195.93, 83.220.169.155, 141.105.71.21, 18.244.96.0/19, 18.244.128.0/19 --dpi-desync=multisplit --dpi-desync-split-seqovl=209 --dpi-desync-split-seqovl-pattern="%~dp0fake\tls_clienthello_5.bin" --dpi-desync-split-pos=sld+1 --dup=2 --dup-cutoff=n3
set YTDB_CFUNBANv6=3 --ipset="%~dp0lists\cloudflare-ipset_v6.txt" --ipset-exclude-ip=2606:4700:4700::1111, 2606:4700:4700::1001 --dpi-desync=multisplit --dpi-desync-split-seqovl=209 --dpi-desync-split-seqovl-pattern="%~dp0fake\tls_clienthello_5.bin" --dpi-desync-split-pos=sld+1 --dup=2 --dup-cutoff=n3

:: Здесь можно включить другую стратегию для Ютуба по протоколу QUIC [интерфейс и googlevideo.com], убрав rem и выключить, добавив rem ::
rem set YTDB_YTQC=--dpi-desync=fake,ipfrag2 --dpi-desync-fake-quic="%~dp0fake\quic_5.bin" --dpi-desync-cutoff=n3 --dpi-desync-repeats=3
rem set YTDB_YTQC=--dpi-desync=fake,udplen --dpi-desync-udplen-increment=4 --dpi-desync-fake-quic="%~dp0fake\quic_4.bin" --dpi-desync-cutoff=n3 --dpi-desync-repeats=2
rem set YTDB_YTQC=--dpi-desync=fake,udplen --dpi-desync-udplen-increment=8 --dpi-desync-udplen-pattern=0xFEA82025 --dpi-desync-fake-quic="%~dp0fake\quic_4.bin" --dpi-desync-cutoff=n4 --dpi-desync-repeats=2
rem set YTDB_YTQC=--dpi-desync=fake,udplen --dpi-desync-udplen-increment=25 --dpi-desync-fake-quic="%~dp0fake\quic_5.bin" --dpi-desync-repeats=2 --dpi-desync-cutoff=n3
rem set YTDB_YTQC=--dpi-desync=fake --dpi-desync-fake-quic="%~dp0fake\quic_1.bin" --dpi-desync-cutoff=n3 --dpi-desync-repeats=6
rem set YTDB_YTQC=[Вы можете добавить сюда свою стратегию]

:: Здесь можно включить другую стратегию для видео Ютуба без QUIC убрав rem и выключить, добавив rem ::
rem set YTDB_WinSZ=43 --hostlist-domains=googlevideo.com --hostlist="%~dp0lists\russia-youtube.txt" --dpi-desync=fake,multisplit --dpi-desync-split-pos=sld+1 --dpi-desync-fake-tls=0x0F0F0E0F --dpi-desync-fake-tls="%~dp0fake\tls_clienthello_14.bin" --dpi-desync-fake-tls-mod=rnd,dupsid --dpi-desync-fooling=md5sig --dpi-desync-autottl --dup=2 --dup-fooling=md5sig --dup-autottl --dup-cutoff=n3
rem set YTDB_WinSZ=43 --hostlist-domains=googlevideo.com --hostlist="%~dp0lists\russia-youtube.txt" --ipcache-hostname --dpi-desync=syndata,fake,multisplit --dpi-desync-split-pos=sld+1 --dpi-desync-fake-syndata="%~dp0fake\tls_clienthello_7.bin" --dpi-desync-fake-tls=0x0F0F0E0F --dpi-desync-fake-tls="%~dp0fake\tls_clienthello_9.bin" --dpi-desync-fake-tls-mod=rnd,dupsid --dpi-desync-fooling=md5sig --dpi-desync-autottl --dup=2 --dup-fooling=md5sig --dup-autottl --dup-cutoff=n3
rem set YTDB_WinSZ=43 --hostlist-domains=googlevideo.com --hostlist="%~dp0lists\russia-youtube.txt" --dpi-desync=fake,multidisorder --dpi-desync-split-pos=7,sld+1 --dpi-desync-fake-tls=0x0F0F0F0F --dpi-desync-fake-tls="%~dp0fake\tls_clienthello_4.bin" --dpi-desync-fake-tls-mod=rnd,dupsid,sni=fonts.google.com --dpi-desync-fooling=badseq --dpi-desync-autottl

:: Здесь можно включить другую стратегию для обхода блокировки хостеров убрав rem и выключить, добавив rem ::
rem set YTDB_CFUNBAN=3 --ipset="%~dp0lists\cloudflare-ipset.txt" --ipset-exclude-ip=1.1.1.1, 1.0.0.1, 212.109.195.93, 83.220.169.155, 141.105.71.21,18.244.96.0/19,18.244.128.0/19 --dpi-desync=syndata,multisplit --synack-split=synack --dpi-desync-split-seqovl=1 --dpi-desync-fake-syndata="%~dp0fake\syn_packet.bin" --dup=2 --dup-cutoff=n3
rem set YTDB_CFUNBAN=3 --ipset="%~dp0lists\cloudflare-ipset.txt" --ipset-exclude-ip=1.1.1.1, 1.0.0.1, 212.109.195.93, 83.220.169.155, 141.105.71.21,18.244.96.0/19,18.244.128.0/19 --dpi-desync=fake,multidisorder --dpi-desync-split-seqovl=1 --dpi-desync-split-pos=sld+1 --dpi-desync-fake-tls=0x0F0F0E0F --dpi-desync-fake-tls="%~dp0fake\tls_clienthello_9.bin" --dpi-desync-fake-tls-mod=rnd,dupsid --dpi-desync-fooling=md5sig --dpi-desync-autottl --dup=2 --dup-fooling=md5sig --dup-autottl --dup-cutoff=n3

:: Здесь можно включить дебаг-лог убрав rem и выключить, добавив rem ::
rem set YTDB_prog_log=--debug=@"%~dp0log_debug.txt" 

set YTDB_RTMPS=43 --ipset="%~dp0lists\russia-youtube-rtmps.txt" --dpi-desync=syndata --dpi-desync-fake-syndata="%~dp0fake\tls_clienthello_7.bin" --dup=2 --dup-cutoff=n3

start "---] zapret: http,https,quic,youtube,discord [---" "%~dp0winws.exe" %YTDB_prog_log%^
--wf-tcp=80,443 --wf-udp=443,50000-50090 ^
--filter-l3=ipv6 --filter-tcp=80,443 --hostlist="%~dp0lists\netrogat.txt" --new ^
--filter-l3=ipv4 --filter-tcp=80,443 --hostlist="%~dp0lists\netrogat.txt" --new ^
--filter-tcp=4%YTDB_RTMPS% --new ^
--filter-udp=443 --hostlist="%~dp0lists\russia-youtubeQ.txt" %YTDB_YTQC% --new ^
--filter-tcp=4%YTDB_WinSZ% --new ^
--filter-tcp=80 --hostlist="%~dp0lists\mycdnlist.txt" --hostlist="%~dp0lists\russia-blacklist.txt" --hostlist="%~dp0lists\myhostlist.txt" --dpi-desync=fake,multisplit --dpi-desync-split-seqovl=2 --dpi-desync-split-pos=sld+1 --dpi-desync-fake-http=0x0E0E0F0E --dpi-desync-fooling=md5sig --dup=2 --dup-fooling=md5sig --dup-cutoff=n3 --new ^
--filter-tcp=443 --hostlist-domains=updates.discord.com, stable.dl2.discordapp.net, animego.online, animejoy.ru, getchu.com, rutracker.org, static.rutracker.cc --dpi-desync=multisplit --dpi-desync-split-seqovl=318 --dpi-desync-split-seqovl-pattern="%~dp0fake\tls_clienthello_15.bin" --new ^
--filter-tcp=443 --hostlist="%~dp0lists\russia-blacklist.txt" --hostlist="%~dp0lists\myhostlist.txt" --hostlist="%~dp0lists\mycdnlist.txt" --dpi-desync=fake,multidisorder --dpi-desync-split-pos=sld+1 --dpi-desync-fake-tls=0x0F0F0E0F --dpi-desync-fake-tls="%~dp0fake\tls_clienthello_10.bin" --dpi-desync-fake-tls-mod=rnd,dupsid --dpi-desync-fooling=md5sig --dpi-desync-autottl --dup=2 --dup-fooling=md5sig --dup-autottl --dup-cutoff=n3 --new ^
--filter-l3=ipv6 --filter-tcp=44%YTDB_CFUNBANv6% --new ^
--filter-l3=ipv4 --filter-tcp=44%YTDB_CFUNBAN% --new ^
--filter-l3=ipv6 --filter-udp=50000-50090 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-autottl6 --dup=2 --dup-autottl6 --dup-cutoff=n3 --new ^
--filter-l3=ipv4 --filter-udp=50000-50090 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-autottl --dup=2 --dup-autottl --dup-cutoff=n3 --new ^
--filter-l3=ipv4 --filter-tcp=80 --hostlist-auto="%~dp0lists\autohostlist.txt" --hostlist-exclude="%~dp0lists\netrogat.txt" --dpi-desync=fake,multisplit --dpi-desync-split-seqovl=2 --dpi-desync-split-pos=host+1 --dpi-desync-fake-http=0x0E0E0F0E --dpi-desync-fooling=md5sig --new ^
--filter-l3=ipv4 --filter-tcp=443 --hostlist-auto="%~dp0lists\autohostlist.txt" --hostlist-exclude="%~dp0lists\netrogat.txt" --dpi-desync=fake,fakedsplit --dpi-desync-split-pos=1 --dpi-desync-fake-tls="%~dp0fake\tls_clienthello_9.bin" --dpi-desync-fooling=badseq --dpi-desync-autottl

goto :EOF

:Preparing
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
del /F /Q "%~dp0logfile.log" > nul
cls
tasklist /fi "IMAGENAME eq RBTray.exe" | find /i "RBTray.exe" > nul
if errorlevel 1 (
    start "" "%~dp0tray\RBTray.exe" > nul
    cls
)
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
 echo Deleting service...
 sc delete zapret > nul
 )
rem exit
)
for /f "skip=3 tokens=1,2,* delims=: " %%i in ('sc query "WinDivert"') do (
 if %%j==4 (
 color fc
 echo WinDivert service is running!
 echo Stopping service...
 net stop WinDivert > nul
 ping -n 3 127.0.0.1 > nul
 )
rem exit
)
ipconfig /flushdns > nul
goto :Zapusk
