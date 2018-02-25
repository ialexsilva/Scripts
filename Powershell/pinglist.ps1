$pclist = Import-Csv H:\pclist.csv
$pclist | ForEach-Object {
   If (Test-Connection -ComputerName $_.PCID -Count 1 -Quiet) {
   Write-Host $_.OldPCID -ForegroundColor Green
   $_.OldPCID | Out-File H:\up.csv -Append
   }
    Else {
   Write-Host $_.PCID -ForegroundColor Red
   } 
   } 
