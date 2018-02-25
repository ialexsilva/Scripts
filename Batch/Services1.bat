@echo off
color 9e
set /p ques=IGT or WIN Service (I,W,N)?
if (%ques%)==(i) goto igt
if (%ques%)==(w) goto win

:go
set /p t=Target?
echo Conecting to %t%
start C:\Windows\system32\services.msc /Computer=%t%
goto done

:igt
set /p t=Target?
echo Conecting to %t%igtservice
start C:\Windows\system32\services.msc /Computer=%t%igtservice
goto done

:win
set /p t=Target?
echo Conecting to stnwinservice%t%
start C:\Windows\system32\services.msc /Computer=stnwinservice%t%
goto done

:done
exit