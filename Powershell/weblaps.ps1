# Load AD Module

if (-not (Get-Module ActiveDirectory)){     
 Import-Module ActiveDirectory -ErrorAction Stop
} 

# Get Data

$PCID = $PoSHQuery.PCID
$UN = $PoSHQuery.UN
$UPASS = $PoSHQuery.PASS

# Check Access

if ($UN -eq "tech")
{
    if ($UPASS -eq "Password")
    {
        try{
        $pass = get-adcomputer -Identity $PCID -Property ms-Mcs-AdmPwd
        $dpass = $pass.'ms-Mcs-AdmPwd'
        }catch{
        $dpass = "No password found"
}
}  
}else
{
$dpass = "Please login"    
}

# Change PCID to all CAPS

try{
$PCID = $PCID.ToUpper()
}catch{
$PCID = ""
}

# Show the webpage

@"
<head>
<title>Web LAPS</title>
</head>
<body>
<form>
Username: <input type="text" name="UN"><br>
Password: <input type="password" name="PASS"><br>
PCID: <input type="text" name="PCID"><br>
<br>
<input type="submit" value="Get Password">
<form action="weblaps.ps1" method="post">
</form>

<font face="courier" size="7">$($PCID) - $($dpass)</font>
</body>
"@