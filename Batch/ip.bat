for /f "skip=1 tokens=2 delims=[]" %%* in (
   'ping.exe -n 1 bainfogen') Do (set "IP=%%*" )
echo %IP%