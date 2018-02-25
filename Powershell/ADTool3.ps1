# Setup window and load AD Module

$host.ui.RawUI.WindowTitle = "Scott's AD Tool" 
$host.ui.RawUI.ForegroundColor = "White"

$width = 62
$sizeWindow = new-object System.Management.Automation.Host.Size $width,16
$sizeBuffer = new-object System.Management.Automation.Host.Size $width,9999
if ($Host.UI.RawUI.WindowSize.width -gt $width) {
$Host.UI.RawUI.WindowSize = $sizeWindow
$Host.UI.RawUI.BufferSize = $sizeBuffer
}
else {
$Host.UI.RawUI.BufferSize = $sizeBuffer
$Host.UI.RawUI.WindowSize = $sizeWindow
}

if (-not (Get-Module ActiveDirectory)){     
 Import-Module ActiveDirectory -ErrorAction Stop
} 

# Setup Functions

function Check-Lockout ($aduser)
{
if($aduser.LockedOut -eq "True"){
Write-Host "Account locked" -ForegroundColor Red
Unlock-AD $aduser
}else{
Write-Host "Account not locked" -ForegroundColor Green
}  
}

function Check-Exp ($aduser)
{
try{
$expiration = ([datetime]::FromFileTime($aduser.'msDS-UserPasswordExpiryTimeComputed'))
}catch{
$expiration = "NEVER"
}
if($expiration -eq "12/31/1600 4:00:00 PM"){
Write-Host "Password must be changed at next logon" -ForegroundColor Yellow    
}
if($expiration -lt (Get-Date) -and $expiration -ne "12/31/1600 4:00:00 PM"){
Write-Host "Password expired" $expiration -ForegroundColor Red
Reset-Exp $aduser
}
if($expiration -le (Get-Date).AddDays(7) -and $expiration -ge (Get-Date)){
Write-Host "Password expires " -ForegroundColor Green -NoNewline
Write-Host $expiration -ForegroundColor Yellow
}
if($expiration -gt (Get-Date).AddDays(7)){
Write-Host "Password expires" $expiration -ForegroundColor Green
}
}

function Unlock-AD ($aduser)
{
Unlock-ADAccount $aduser
Write-Host "Unlocked Account" -ForegroundColor Green
}

function Reset-Pass ($aduser)
{
$resetpass = Read-Host "Reset Password? (y/n)"
if($resetpass -eq "y"){
$pass = ConvertTo-SecureString 'Password01' -AsPlainText -Force
Set-ADAccountPassword $aduser -NewPassword $pass
Write-Host "Password set to " -ForegroundColor Green -NoNewline
Write-Host "Password01" -ForegroundColor Yellow  
Force-Reset $aduser
}
}

function Force-Reset ($aduser)
{
$forcereset = Read-Host "Force password reset? (y/n)"
if($forcereset -eq "y"){
Set-aduser $aduser -changepasswordatlogon $true
Write-Host "Password must be changed at next logon" -ForegroundColor Yellow    
}
}

function Reset-Exp ($aduser)
{
$resetexp = Read-Host "Reset expiration? (y/n)"
if($resetexp -eq "y"){
$aduser.pwdlastset = 0 
Set-ADUser -Instance $aduser
$aduser.pwdlastset = -1 
Set-ADUser -instance $aduser
Write-Host "Expiration reset" -ForegroundColor Green
}  
}

function Check-Acc ($aduser)
{
if($aduser.Enabled -eq $false){
Write-Host "Account is disabled" -ForegroundColor Red
Write-Host
Continue
}
if($aduser.AccountExpirationDate -ne $null -and $aduser.AccountExpirationDate -lt (Get-Date)){
Write-Host "Account exprired" $aduser.AccountExpirationDate -ForegroundColor Red
Write-Host
Continue
}
}

function Clean-Var ()
{
Clear-Variable user, aduser, expiration, resetexp, resetpass, pass, forcereset -ErrorAction SilentlyContinue
}


# Loop

do{

$user = Read-Host "Username?"
try{
$aduser = Get-ADUser $user -Properties LockedOut, pwdlastset, AccountExpirationDate, "msDS-UserPasswordExpiryTimeComputed"
}
catch{
Write-Host "Unable to find account" -ForegroundColor Red
Write-Host
Continue
}

Write-Host
Write-Host $aduser.Name 

Check-Acc $aduser
Check-Lockout $aduser
Check-Exp $aduser
Reset-Pass $aduser
Clean-Var
Write-Host
}
while($user -ne "exit")