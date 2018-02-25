Do{
Write-Host
$PCID = Read-Host -Prompt PCID?
Write-Host
If (Test-Connection -ComputerName $PCID -Count 1 -Quiet) {
   Write-Host PC $PCID pings checking for folder -ForegroundColor Green;
   If (Test-Path \\$PCID\C$\WINLogs) {
   Write-Host PC $PCID has a WINLogs folder -ForegroundColor Green;
   }
   Else {
   Write-Host PC $PCID does not have a WINLogs folder -ForegroundColor Red
   }  
  }
Else {
  Write-Host Unable to ping $PCID -ForegroundColor Red; $PCID | Out-File H:\noping.csv -Append
  }  
  }
  while ($PCID -ne "exit")    