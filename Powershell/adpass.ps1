$pass = ConvertTo-SecureString -AsPlainText “Password19” -Force
$loop = "yes"
do{
$user = Read-Host -Prompt "Username"
Get-ADUser -Identity $user
Unlock-ADAccount -Identity $user
Set-ADAccountPassword -Identity $user -NewPassword $pass
Set-ADuser $user -ChangePasswordAtLogon false
}
while($loop -eq 'yes')