if (-not (Get-Module ActiveDirectory)){     
 Import-Module ActiveDirectory -ErrorAction Stop
} 

$user = "Ikasen"
$count = 0
$unlocktime = "N/A"

do{
$status = (Get-Aduser $user -Properties LockedOut -Server N7VDC00).LockedOut
Write-Host $user "locked ="$status

If($status -eq "True")
{
Unlock-ADAccount -Identity $user -Server N7VDC00
Write-Host "Unlocked Account" $user
$count = $count + 1
$unlocktime = Get-Date
}
Get-Date | Write-Host
Write-Host "Account Unlocked" $count "times"
Write-Host "Last Unlock =" $unlocktime
Write-Host "Waiting 60s"
Start-Sleep -Seconds 60
cls
}
while ($user -ne "exit")