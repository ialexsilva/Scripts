@echo off
color 9e
title Restart Neuron ESB Services

call stopserv.bat STNESB01 Neuron ESB
call stopserv.bat STNESB02 Neuron ESB

echo.
echo Waiting to start services
pause

call startserv.bat STNESB01 Neuron ESB
call startserv.bat STNESB02 Neuron ESB

echo.
echo Done
pause