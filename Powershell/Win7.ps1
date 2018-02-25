if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
Write-Host Starting VM
get-vm -Name win7 | start-vm
Start-Sleep -Seconds 30
Write-Host Connecting
Start-Process mstsc "c:\zit8926.rdp" -Wait
get-vm -Name win7 | Stop-VM