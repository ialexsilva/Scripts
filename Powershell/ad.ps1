if (-not (Get-Module ActiveDirectory)){     
 Import-Module ActiveDirectory -ErrorAction Stop
} 
$loop = 'yes'  
do{
$pass = ConvertTo-SecureString 'password' -AsPlainText -Force
$uname = Read-Host 'Username?'
Get-ADUser $uname -Properties * | Format-Table -Property DisplayName, LockedOut, PasswordExpired  -AutoSize
$action = Read-Host '(u)nlock, (r)eset Password, (b)oth, or (d)one?'
if ($action -eq 'u'){
Unlock-ADAccount $uname -PassThru
Write-Host
Write-Host $uname 'Unlocked'
Write-Host
$action2 = Read-Host 'Reset Password? (y/n)'
if ($action2 -eq 'y'){
Set-ADAccountPassword $uname -NewPassword $pass -PassThru
Write-Host
Write-Host $uname 'password set to password'}
}
if ($action -eq 'r'){
Set-ADAccountPassword $uname -NewPassword $pass -PassThru
Write-Host $uname 'password set to password'}
if ($action -eq 'b'){
Unlock-ADAccount $uname -PassThru
Write-Host
Write-Host $uname 'Unlocked'
Set-ADAccountPassword $uname -NewPassword $pass -PassThru
Write-Host
Write-Host $uname 'password set to password'}
Write-Host
if ($action -eq 'd'){
Write-Host}
}
while($loop -eq 'yes')