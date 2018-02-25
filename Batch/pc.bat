@echo off
color 9E
title Install Profile Cleanup
echo.

copy "H:\Install Files\UPHClean-Setup.msi" "\\%1\c$\"

psexec \\%1 -e -s msiexec.exe /i c:\UPHClean-Setup.msi /quiet /qn /norestart

title Install Profile Cleanup

goto el%errorlevel%

echo.
echo Unknown Error
goto :end

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
del "\\%1\c$\UPHClean-Setup.msi"
echo.
echo Press enter to exit
pause
