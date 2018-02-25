@echo off
color 9e
set /p t=Target?
echo Conecting to %t%
start C:\Windows\system32\services.msc /Computer=%t%