
do{
$user = Read-Host -Prompt "Username"
echo " "
$ran = Get-Random -Maximum 99 -Minimum 10
$pass = "Password" + $ran
echo $pass
echo " "
$spass = ConvertTo-SecureString -AsPlainText $pass -Force
Get-ADUser -Identity $user
Unlock-ADAccount -Identity $user
Set-ADAccountPassword -Identity $user -NewPassword $spass -PassThru
Set-ADuser -Identity $user -ChangePasswordAtLogon $false
}
while($user -ne 'exit')