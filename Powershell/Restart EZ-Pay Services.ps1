$servers = ("TGIGTSERVICE","WWIGTSERVICE","WAIGTBOX","MSIGTSERVICE","LMSLOTS1","RNIGTSERVICE","WFIGTSERVICE","GRIGTSERVICE","WVIGTBOX")
ForEach ($_ in $servers){
    Write-Host $_ -ForegroundColor Green
    Write-Host 
    Get-Service -ComputerName $_ -Name ezpay_rmiregistry | Stop-Service -Force -Verbose
    Get-Service -ComputerName $_ -Name ezpay_rmiregistry | Start-Service -Verbose
    Get-Service -ComputerName $_ -Name ezpay_db_rpt_server | Start-Service -Verbose
    Get-Service -ComputerName $_ -Name ezpay_db_app_server | Start-Service -Verbose
    Get-Service -ComputerName $_ -Name ezpay_rmiregistry,ezpay_db_rpt_server,ezpay_db_app_server | Format-Table -AutoSize -HideTableHeaders -Property MachineName,ServiceName,Status 
    Write-Host}
    Pause