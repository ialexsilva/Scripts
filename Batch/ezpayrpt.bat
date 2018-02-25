@echo off
color 9e

echo Let's go!
echo.
pause
echo.
echo Wildfire Boulder

call stopserv.bat msigtservice ezpay_db_app_server
call stopserv.bat msigtservice ezpay_db_rpt_server
call stopserv.bat msigtservice ezpay_rmiregistry

call startserv.bat msigtservice ezpay_db_app_server
call startserv.bat msigtservice ezpay_db_rpt_server
call startserv.bat msigtservice ezpay_rmiregistry


echo %TIME%
echo.
echo Wildfire Sunset

call stopserv.bat grigtservice ezpay_db_app_server
call stopserv.bat grigtservice ezpay_db_rpt_server
call stopserv.bat grigtservice ezpay_rmiregistry

call startserv.bat grigtservice ezpay_db_app_server
call startserv.bat grigtservice ezpay_db_rpt_server
call startserv.bat grigtservice ezpay_rmiregistry


echo %TIME%
echo.
echo Wildfire Lanes

call stopserv.bat rnigtservice ezpay_db_app_server
call stopserv.bat rnigtservice ezpay_db_rpt_server
call stopserv.bat rnigtservice ezpay_rmiregistry

call startserv.bat rnigtservice ezpay_db_app_server
call startserv.bat rnigtservice ezpay_db_rpt_server
call startserv.bat rnigtservice ezpay_rmiregistry


echo %TIME%
echo.
echo Barley's 

call stopserv.bat baigtservice ezpay_db_app_server
call stopserv.bat baigtservice ezpay_db_rpt_server
call stopserv.bat baigtservice ezpay_rmiregistry

call startserv.bat baigtservice ezpay_db_app_server
call startserv.bat baigtservice ezpay_db_rpt_server
call startserv.bat baigtservice ezpay_rmiregistry


echo %TIME%
echo.
echo The Greens 

call stopserv.bat tgigtservice ezpay_db_app_server
call stopserv.bat tgigtservice ezpay_db_rpt_server
call stopserv.bat tgigtservice ezpay_rmiregistry

call startserv.bat tgigtservice ezpay_db_app_server
call startserv.bat tgigtservice ezpay_db_rpt_server
call startserv.bat tgigtservice ezpay_rmiregistry


echo %TIME%
echo.
echo Wild West

call stopserv.bat wwigtservice ezpay_db_app_server
call stopserv.bat wwigtservice ezpay_db_rpt_server
call stopserv.bat wwigtservice ezpay_rmiregistry

call startserv.bat wwigtservice ezpay_db_app_server
call startserv.bat wwigtservice ezpay_db_rpt_server
call startserv.bat wwigtservice ezpay_rmiregistry

echo %TIME%
echo.
echo Wildfire Valley View

call stopserv.bat wvigtbox ezpay_db_app_server
call stopserv.bat wvigtbox ezpay_db_rpt_server
call stopserv.bat wvigtbox ezpay_rmiregistry

call startserv.bat wvigtbox ezpay_db_app_server
call startserv.bat wvigtbox ezpay_db_rpt_server
call startserv.bat wvigtbox ezpay_rmiregistry

echo %TIME%
echo.
echo Wildfire Anthem
call stopserv.bat waigtbox ezpay_db_app_server
call stopserv.bat waigtbox ezpay_db_rpt_server
call stopserv.bat waigtbox ezpay_rmiregistry

call startserv.bat waigtbox ezpay_db_app_server
call startserv.bat waigtbox ezpay_db_rpt_server
call startserv.bat waigtbox ezpay_rmiregistry


echo %TIME%

start C:\Windows\System32\services.msc /Computer=wfigtservice

color 4F
echo.
echo Done =)
pause