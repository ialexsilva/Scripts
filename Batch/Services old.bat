@echo off
color 9e
set /p ques=IGT?
if (%ques%)==(i) goto igt
if (%ques%)==(y) goto igt

:go
set /p t=Target?
echo Conecting to %t%
start C:\Windows\system32\services.msc /Computer=%t%
goto done

:igt
set /p t=Property?
echo Conecting to %t%igtservice
start C:\Windows\system32\services.msc /Computer=%t%igtservice
goto done

:done
exit