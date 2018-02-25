@echo off
title %1
echo.
net user %1 /domain | FIND "Password"
echo.
pause