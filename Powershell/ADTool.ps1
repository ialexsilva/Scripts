$host.ui.RawUI.WindowTitle = "Scott's AD Tool"

if (-not (Get-Module ActiveDirectory)){     
 Import-Module ActiveDirectory -ErrorAction Stop
} 

do{

$user = Read-Host "Username?"
try{
$aduser = Get-ADUser $user -Properties LockedOut, pwdlastset, "msDS-UserPasswordExpiryTimeComputed" -Server N7VDC00
}catch{
Write-Host "Oops unable to find account" -ForegroundColor Red
Write-Host
Continue
}

try{
$expiration = ([datetime]::FromFileTime($aduser.'msDS-UserPasswordExpiryTimeComputed'))
}catch{
$expiration = "Never"
}

if($aduser.LockedOut -eq "True"){
Write-Host "Account locked" -ForegroundColor Red
Unlock-ADAccount $aduser -Server N7VDC00
Write-Host "Unlocked Account" -ForegroundColor Green
}else{
Write-Host "Account not locked" -ForegroundColor Green
}


if($expiration -lt (Get-Date)){
if($expiration -eq "12/31/1600 4:00:00 PM"){
Write-Host "Password must be changed at next logon" -ForegroundColor Yellow
}else{
Write-Host "Password expired" $expiration -ForegroundColor Red
$resetexp = Read-Host "Reset expiration? (y/n)"
if($resetexp -eq "y"){
$aduser.pwdlastset = 0 
Set-ADUser -Instance $aduser -Server N7VDC00
$aduser.pwdlastset = -1 
Set-ADUser -instance $aduser -Server N7VDC00
Write-Host "Expiration reset" -ForegroundColor Green
}else{
if($expiration -le (Get-Date).AddDays(10)){
Write-Host "Password expires " -ForegroundColor Green -NoNewline
Write-Host $expiration -ForegroundColor Yellow
}else{
Write-Host "Password expires" $expiration -ForegroundColor Green
}
}
}
}

$resetpass = Read-Host "Reset Password? (y/n)"

if($resetpass -eq "y"){
$pass = ConvertTo-SecureString 'Password01' -AsPlainText -Force
Set-ADAccountPassword $user -NewPassword $pass
Write-Host "Password set to " -ForegroundColor Green -NoNewline
Write-Host "Password01" -ForegroundColor Yellow
$forcereset = Read-Host "Force reset? (y/n)"
if($forcereset -eq "y"){
Set-aduser $user -changepasswordatlogon $true -Server N7VDC00
Write-Host "Password must be changed at next logon" -ForegroundColor Yellow
}
}
Clear-Variable user, aduser, expiration, resetexp, resetpass, pass, forcereset -ErrorAction SilentlyContinue
Write-Host
}
while($user -ne "exit")