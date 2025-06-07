title ---] Проверка версии Windows... [---
@echo off
PUSHD "%~dp0"
setlocal
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "6.1" (
color FD
echo.
echo !!!ВНИМАНИЕ!!!
echo.
echo Обнаружена Windows 7. На Win 7 нормальная работа всех файлов может быть
echo нарушена, если в пути к папке YTDisBystro будут русские буквы. Если у вас
echo имя пользователя на русском языке, нельзя размещать папку YTDisBystro в
echo Загрузках или на Рабочем столе.
echo Перенесите папку например в созданную папку на диске С: или в какую-нибудь
echo папку без русских букв в пути на диске D: После этого запустите файл
echo !!!get_zapret_first!!!.cmd еще раз и ответьте Y на вопрос "Все равно
echo продолжить?".
echo.
echo Сейчас путь к папке: "%~dp0"
echo Если вы не видите непонятных символов или русских букв в строчке с путем к
echo папке выше, между кавычками - ответьте Y прямо сейчас.
echo.
goto :PROMPT
)

goto :END

:PROMPT
set /P AREYOUSURE=Всё равно продолжить (Y/[N])?
if /I "%AREYOUSURE%" NEQ "N" goto :END

:MEAT
endlocal
exit

:END
endlocal > nul
"!!!get_zapret_first!!!.cmd :startall" > nul
