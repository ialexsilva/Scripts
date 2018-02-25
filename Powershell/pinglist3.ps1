$pclist = Import-Csv H:\pclist.csv
$pclist | ForEach-Object {
   If (Test-Connection -ComputerName $_.Machine_name -Count 1 -Quiet) {
   Write-Host $_.Machine_name -ForegroundColor Green
   }
    Else {
   Write-Host $_.Machine_name -ForegroundColor Red
   $_ | Export-Csv H:\down.csv -Append
   } 
   } 
