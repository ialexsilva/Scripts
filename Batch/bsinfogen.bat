@echo off
:start

echo killing process
TASKKILL /S bsinfogen /IM kitchenprn.exe /T /F

echo waiting 10 seconds
h:\batch\sleep.exe 10

echo starting service
call h:\batch\startserv.bat bsinfogen KitchenPrinter

echo.
echo %TIME%
echo.
echo sleeping
echo.
h:\batch\sleep.exe 3600

goto start