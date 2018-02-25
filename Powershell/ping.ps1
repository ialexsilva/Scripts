#requires -version 3
param([Parameter(Mandatory=$true)]$IP, $lowMS = 0, $highMS = 20, [switch]$AutoScale, $WarnIfRoundtripHigherThan = 0, $msBetweenPings = 1000) 

$ping = New-Object System.Net.NetworkInformation.Ping

while($true) { 
    #this goes here so graph size can be changed on the fly
    $count = [console]::WindowWidth-10

    #send ping
    $reply = $ping.Send($IP)

    #generate timestamp
    $now = [datetime]::Now
    $time = "{0:d4}-{1:d2}-{2:d2} {3:d2}:{4:d2}:{5:d2}.{6:d3}" -f $now.Year, $now.Month, $now.Day, $now.Hour, $now.Minute, $now.Second, $now.Millisecond

    #add result to list array
    $list += @($reply.RoundtripTime)

    #get workingset
    $workingSet = $list | select -last $count

    #calculate graph height if autoscale is on
    if($AutoScale) {
        [int]$lowMS = 999
        [int]$highMS = 0
        $workingSet | % { 
            if($_ -gt $highMS) { $highMS = $_ }
            if($_ -lt $lowMS) { $lowMS = $_ }
        }
    }

    #generate graph
    $screen = ("Last ping at: $time - Target: $IP`nAutoScale: {0} - WarnIfRoundtripHigherThan: {1}`n`n" -f $(if($AutoScale) { "On" } else { "Off" }), $(if($WarnIfRoundtripHigherThan -ne 0) { "$($WarnIfRoundtripHigherThan)ms" } else { "Off" }))
    for($y = $highMS; $y -ge $lowMS; $y--) {
        $screen += ("{0:d3}ms | " -f $y)
        for($x = 0; $x -lt $count; $x++) {
            if($y -eq $highMS -and $workingSet[$x] -gt $highMS) {
                $screen += "^"
            }
            else {
                if($workingSet[$x] -eq $y) { 
                    $screen += "."
                }
                else { 
                    $screen += " "
                }
            }
        }
        $screen += "`n"
    }

    #bottom of the graph
    $screen += "      |"
    for($x = 0; $x -le $count; $x++) {
        $screen += "_"
    }

    #write warning if roundtrip is too high
    if($WarnIfRoundtripHigherThan -ne 0) {
        if($reply.RoundtripTime -gt $WarnIfRoundtripHigherThan) {
            $screen += "`n`nWarning! Roundtrip time too high!`a`a"
        }
    }

    cls
    $screen

    sleep -Milliseconds $msBetweenPings
}