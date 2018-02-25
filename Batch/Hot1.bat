@echo off
color 9e
title Restart MDA Services
:start
echo.
set /p prop=Property?
echo.

call stopserv.bat %prop%HOT1 MDA_dticker
call stopserv.bat %prop%HOT1 MDA_sperf
call stopserv.bat %prop%HOT1 W3SVC

call startserv.bat %prop%HOT1 W3SVC
call startserv.bat %prop%HOT1 MDA_sperf
call startserv.bat %prop%HOT1 MDA_dticker


goto start