@Echo Off

:top
powershell.exe -file C:\cascraper3.ps1
echo Error at %DATE% %TIME% >> "C:\cascraper3.log"
sleep 300
echo Restarted at %DATE% %TIME% >> "C:\cascraper3.log"
goto top


