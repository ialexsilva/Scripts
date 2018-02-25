# Setup window

$host.ui.RawUI.WindowTitle = "Scott's CA Scraper" 
$host.ui.RawUI.ForegroundColor = "White"
$ErrorActionPreference = "Stop"

# Setup Functions

function sendemail ($to, $body)
{
    Send-MailMessage -To $to -Subject "New Ticket" -From "scott.sullivan@stationcasinos.com" -Body $body -SmtpServer stnrelay.stationcasinos.net       
}

function docheck ($property)
{
    $site = Invoke-WebRequest -Uri $property.url -WebSession $mysession
    $property.count = $site.ParsedHtml.body.innerText.Length

    if ($property.count -le $property.pcount)
    {
     $property.pcount = $property.count
     Write-Host "$($property.code) checked at $(get-date)"    
    }
    else
    {
     $property.pcount = $property.count
     sendemail $property.techs $site.ParsedHtml.body.innerText
     Write-Host "$($property.code) checked at $(get-date) email sent" -ForegroundColor Green
    }  
    ${$property.code} = $property 
}

# Login to CA

$site = Invoke-WebRequest -Uri http://stncaapp1:8080 -SessionVariable mysession
$form = $site.Forms[0]
$form.fields['USERNAME'] = "scsulli"
$site = Invoke-WebRequest -Uri ('http://stncaapp1:8080' + $form.Action) -WebSession $mysession -Method POST -Body $form.Fields
$id = ($site.Links | Where innerText -eq "LogOut").href.Substring(18, 14)

# Setup properties

$SF = New-Object psobject -Property @{
    code = "SF"
    url = "http://stncaapp1:8080/CAisd/pdmweb.exe?+$id+FID=8674+OP=SEARCH+FACTORY=cr+KEEP.where_clause=active%20%3D%201%20AND%20customer.location%20%3D%20U%2711C8FA082C19DB40B5D483199A031722%27%20AND%20group%20%3D%20U%275FD3BC70EA394744AE4C39F892000B54%27"
    count = ""
    pcount = ""
    techs = "scott.sullivan@stationcasinos.com","Klayton.Bemoll@StationCasinos.com"
}

$NS = New-Object psobject -Property @{
    code = "NS"
    url = "http://stncaapp1:8080/CAisd/pdmweb.exe?+$id+FID=2730+OP=SEARCH+FACTORY=cr+KEEP.where_clause=active%20%3D%201%20AND%20group%20%3D%20U%275FD3BC70EA394744AE4C39F892000B54%27%20AND%20status%20%3D%20%27OP%27"
    count = ""
    pcount = ""
    techs = "Alexander.Manger@StationCasinos.com"
}


# Loop every 5 minutes

do{
    docheck $SF
    Start-Sleep -s 5
    docheck $NS
    Start-Sleep -s 300
}
while($exit -ne "exit")