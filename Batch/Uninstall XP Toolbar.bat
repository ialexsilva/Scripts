@echo off
title Unistall Office XP Toolbar
set /p PCID=PCID?

psexec -e \\%PCID% MsiExec.exe /x{90110409-6000-11D3-8CFE-0050048383C9} /q

goto el%errorlevel%

echo.
echo Unknown Error
goto :end

:el1605
echo.
echo Not Installed
goto end

:el1603
echo.
color 4F
echo Opps didn't work =(
goto end

:el0
echo.
echo It worked =)
goto end

:el1030
echo.
echo It works but needs a restart =)
goto end

:end
echo.
pause

