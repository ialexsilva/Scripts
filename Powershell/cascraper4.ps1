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
     Write-Output "$($property.code) checked at $(get-date) count $($property.count)" | Out-File C:\cascraper4.log -Append ascii    
    }
    else
    {
     $property.pcount = $property.count
     sendemail $property.techs $site.ParsedHtml.body.innerText
     Write-Output "$($property.code) checked at $(get-date) email sent $($property.count)" | Out-File C:\cascraper4.log -Append ascii
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
    url = "http://stncaapp1:8080/CAisd/pdmweb.exe?+$id+FID=8892+OP=SEARCH+FACTORY=cr+KEEP.where_clause=active%20%3D%201%20AND%20customer.location%20%3D%20U%2711C8FA082C19DB40B5D483199A031722%27%20AND%20group%20%3D%20U%275FD3BC70EA394744AE4C39F892000B54%27"
    count = ""
    pcount = ""
    techs = "scott.sullivan@stationcasinos.com", "Klayton.Bemoll@StationCasinos.com"
}

$NS = New-Object psobject -Property @{
    code = "NS"
    url = "http://stncaapp1:8080/CAisd/pdmweb.exe?+$id+FID=2730+OP=SEARCH+FACTORY=cr+KEEP.where_clause=active%20%3D%201%20AND%20group%20%3D%20U%275FD3BC70EA394744AE4C39F892000B54%27%20AND%20status%20%3D%20%27OP%27"
    count = ""
    pcount = ""
    techs = "Alexander.Manger@StationCasinos.com"
}

$WF = New-Object psobject -Property @{
    code = "WF"
    url = "http://stncaapp1:8080/CAisd/pdmweb.exe?+$id+FID=3178+OP=SEARCH+FACTORY=cr+KEEP.where_clause=active%20%3D%201%20AND%20customer.location%20%3D%20U%270CCB960E69B1A14EA336514860CA211D%27%20AND%20group%20%3D%20U%275FD3BC70EA394744AE4C39F892000B54%27"
    count = ""
    pcount = ""
    techs = "Jeffrey.Woodrum@StationCasinos.com"
}

$FR = New-Object psobject -Property @{
    code = "FR"
    url = "http://stncaapp1:8080/CAisd/pdmweb.exe?+$id+FID=2930+OP=SEARCH+FACTORY=cr+KEEP.where_clause=active%20%3D%201%20AND%20customer.location%20%3D%20U%2726E1C838C191A842867AF431BE1EC5AA%27%20AND%20group%20%3D%20U%275FD3BC70EA394744AE4C39F892000B54%27"
    count = ""
    pcount = ""
    techs = "Jeffrey.Woodrum@StationCasinos.com"
}


# Loop every 5 minutes

do{
    docheck $SF
    if ($sf.count -eq 127 -or $sf.count -eq 24 -or $sf.count -eq 208 -or $sf.count -eq 39)
        {
        exit  
        }
    Start-Sleep -s 300
}
while($exit -ne "exit")