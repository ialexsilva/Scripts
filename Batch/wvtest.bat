call stopserv.bat waigtbox ezpay_db_app_server
call stopserv.bat waigtbox ezpay_db_rpt_server
call stopserv.bat waigtbox ezpay_rmiregistry

call startserv.bat waigtbox ezpay_db_app_server
call startserv.bat waigtbox ezpay_db_rpt_server
call startserv.bat waigtbox ezpay_rmiregistry

pause