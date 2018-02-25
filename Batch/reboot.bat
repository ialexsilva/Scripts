@echo off
color 9E
title Shutdown
echo Sending Shutdown
shutdown /m \\%1 /r /t 1 /f
call h:\Batch\pauto.bat %1
