@ECHO OFF
PUSHD "%~dp0"
color f1

:: Включить запуск программы в качестве службы. (В разработке) ::
set YTDB_RUN_AS_SERVICE=0

:: Включить (установив в 0) если ваш провайдер выдает рабочий адрес IPv6 :: 
set YTDB_IPV6_OFF=1

:: Отключить AUTOTTL для стратегий с фейками (установив в 1), если он у вас работает нестабильно. Если не знаете что это - не трогайте ::
set YTDB_AUTOTTL_OFF=0

:: Включить фиксированный TTL (после отключения AUTO), установив в 0 :: 
set YTDB_TTL_OFF=1
:: Значение фиксированного TTL для фейков. Подбирается минимальное значение, при котором у вас откроются все нужные вам сайты ::
set YTDB_TTL_NUM=5

:: Пресет для сайтов. От 1 до 11 или же Custom. Пресет 11 не поддерживает сайты на TLS 1.2! Например Х с ним не откроется ::
set YTDB_TLS_MAIN_SET=1
set "YTDB_TLS_MAIN_Custom=--dpi-desync=fakedsplit"

:: Пресет для Дискорда. От 1 до 11 или же Custom ::
set YTDB_TLS_MAIN2_SET=1
set "YTDB_TLS_MAIN2_Custom=--dpi-desync=fakedsplit"

:: Пресет для QUIC на YouTube или же для WARP. От 1 до 3 или же Custom :: 
set YTDB_QUIC_MAIN_SET=1
set "YTDB_QUIC_MAIN_Custom=--dpi-desync=fake"

:: Здесь можно включить дебаг-лог (установив в 1) ::
:: НЕ ВКЛЮЧАТЬ без надобности - приводит к тормозам соединения или полному отключению обхода! ::
set YTDB_ZAPRET_LOG_ON=0

:: DON'T TOUCH NOTHING BELOW OF THIS!!! ::
setx YTDB_AUTOTTL_OFF "%YTDB_AUTOTTL_OFF%" > nul
setx YTDB_IPV6_OFF "%YTDB_IPV6_OFF%" > nul
setx YTDB_TTL_OFF "%YTDB_TTL_OFF%" > nul
setx YTDB_TTL_NUM "%YTDB_TTL_NUM%" > nul
setx YTDB_TLS_MAIN_SET "%YTDB_TLS_MAIN_SET%" > nul
setx YTDB_TLS_MAIN_Custom "%YTDB_TLS_MAIN_Custom%" > nul
setx YTDB_QUIC_MAIN_SET "%YTDB_QUIC_MAIN_SET%" > nul
setx YTDB_QUIC_MAIN_Custom "%YTDB_QUIC_MAIN_Custom%" > nul
setx YTDB_TLS_MAIN2_SET "%YTDB_TLS_MAIN2_SET%" > nul
setx YTDB_TLS_MAIN2_Custom "%YTDB_TLS_MAIN2_Custom%" > nul
setx YTDB_ZAPRET_LOG_ON "%YTDB_ZAPRET_LOG_ON%" > nul
cls
cd /d "%~dp0"
if %YTDB_RUN_AS_SERVICE%==0 (
"1_preset_russia_NL.exe"
exit
)
"2_service_install_reinstall_NL.exe"
exit
