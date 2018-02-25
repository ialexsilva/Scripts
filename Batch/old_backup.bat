@echo off
color 9e
echo.
echo Backing up to ZIT0478
robocopy h:\ \\ZIT0478\c$\Windows\bu /mir
robocopy c:\s\ \\ZIT0478\c$\Windows\bus /mir
echo.
echo Backing up to ZIT0474
robocopy h:\ \\ZIT0474\c$\Windows\bu /mir
robocopy c:\s\ \\ZIT0474\c$\Windows\bus /mir
echo.
pause