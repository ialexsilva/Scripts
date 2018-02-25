$ErrorActionPreference = "Stop"

# Setup Function

function sendemail ($body)
{
 Send-MailMessage -To "scott.sullivan@stationcasinos.com","Klayton.Bemoll@StationCasinos.com" -Subject "New Ticket" -From "scott.sullivan@stationcasinos.com" -Body $body -SmtpServer stnrelay.stationcasinos.net       
}

# Login to CA

$site = Invoke-WebRequest -Uri http://stncaapp1:8080 -SessionVariable mysession
$form = $site.Forms[0]
$form.fields['USERNAME'] = "scsulli"
$site = Invoke-WebRequest -Uri ('http://stncaapp1:8080' + $form.Action) -WebSession $mysession -Method POST -Body $form.Fields
$id = ($site.Links | Where innerText -eq "LogOut").href.Substring(18, 14)
$sftickets = "http://stncaapp1:8080/CAisd/pdmweb.exe?+$id+FID=8674+OP=SEARCH+FACTORY=cr+KEEP.where_clause=active%20%3D%201%20AND%20customer.location%20%3D%20U%2711C8FA082C19DB40B5D483199A031722%27%20AND%20group%20%3D%20U%275FD3BC70EA394744AE4C39F892000B54%27"

# Loop every 5 minutes

do{

$site = Invoke-WebRequest -Uri $sftickets -WebSession $mysession
$count = $site.ParsedHtml.body.innerText.Length

if ($count -le $pcount)
{
 $pcount = $count   
}
else
{
 $pcount = $count
 sendemail $site.ParsedHtml.body.innerText    
}

cls
Write-Host Last Run 
Get-Date
Start-Sleep -s 300
}
while($exit -ne "exit")