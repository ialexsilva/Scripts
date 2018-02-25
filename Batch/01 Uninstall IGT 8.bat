@echo off
cls
title IGT Uninstall

echo Uninstalling Advantage Monitor
MsiExec.exe /x{6D623E35-22E7-43DA-923E-8B59C0C8A29D} /qr
echo.

echo Uninstalling Machine Accounting
MsiExec.exe /X{6DC044E0-B00F-4F36-891C-24B15BC95740} /qr
echo.

echo Uninstalling EZPay Client
MsiExec.exe /x{C8397DE9-5F68-48A5-A348-66ACEF135B41} /qr
echo.

echo Uninstalling Advantage Shared Components
MsiExec.exe /x{9E74A7CB-FA62-4BB0-94C8-C762EC05D265} /qr
echo.

echo Done
echo.

pause
