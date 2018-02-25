$pclist = Import-Csv H:\pclist.csv
$pclist | ForEach-Object {
   If (Test-Connection -ComputerName $_.Machine_name -Count 1 -Quiet) {
   Write-Host $_.OldPCID -ForegroundColor Green
   $_.Pings = "Yes"
   $_ | Export-Csv H:\up.csv -Append
   }
    Else {
   Write-Host $_.OldPCID -ForegroundColor Red
   $_.Pings = "No"
   $_ | Export-Csv H:\up.csv -Append
   } 
   } 
