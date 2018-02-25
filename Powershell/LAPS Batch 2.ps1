
# to-do
# error handling

# Scott's LAPS Batch tool version 2

if (-not (Get-Module ActiveDirectory)){     
 Import-Module ActiveDirectory -ErrorAction Stop
} 

# Setup functions

Function Get-FileName()
{
[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    
$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$OpenFileDialog.filter = "CSV (*.csv)| *.csv"
$OpenFileDialog.ShowDialog() | Out-Null
$OpenFileDialog.filename
}

Function Get-SaveFileName()
{
[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    
$SaveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
$SaveFileDialog.filter = "CSV (*.csv)| *.csv"
$SaveFileDialog.ShowDialog() | Out-Null
$SaveFileDialog.filename
}

# Get data

$inputfile = Get-FileName
$PCIDs = Import-Csv $inputfile -Header @("PCID")

# Proccess Data

$data = $PCIDs | ForEach-Object{Get-ADComputer -Identity $_.PCID -Properties ms-Mcs-AdmPwd,ms-Mcs-AdmPwdExpirationTime | Select-Object Name,@{Name="Password";Expression={$_.'ms-Mcs-AdmPwd'}},@{Name="Expires";Expression={[datetime]::FromFileTime($_.'ms-Mcs-AdmPwdExpirationTime')}}}

# Export Data

$saveas = Get-SaveFileName
$data | Export-Csv $saveas -NoTypeInformation
exit