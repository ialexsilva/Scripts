    <#
    .SYNOPSIS
	    Remove user profiles from a specified system

    .DESCRIPTION
	    Remove user profiles from a specified system

        Notes:
            -WMI must be healthy and remotely accessible.  Will add CIM at some point.
            -This script requires confirmation unless you specify -confirm:$false
            -Last access time is pulled from LastUseTime of WMI object in Vista+, LastWriteTime of file system in XP 
            -Standard accounts such as NetworkService are excluded unless you explicitly enable the DontExcludeStandardAccounts switch
            -Exceptions and Profiles to remove are confirmed via standard regex.  Each item you provide goes in this: "^USERNAME$"
                  -Example using this beyond providing a simple username: -profiles JohnD.* will find any username starting JohnD.
	
    .PARAMETER ComputerName
        Computer(s) on which to remove profiles

    .PARAMETER Days
        Remove profiles older than this many days.  Default: 1

    .PARAMETER Exceptions
        Usernames to exclude.  Example:  administrator, ctxservice

    .PARAMETER Profiles
        Specific profiles to remove.  Example: user1, user2

    .PARAMETER DontExcludeStandardAccounts
        Switch to exclude standard profiles or folders
            Administrator
            LocalService
            NetworkService
            All Users
            Default User

    .EXAMPLE
        Remove-Profile -computername computer1 -days 1 -exceptions administrator -confirm:$false

        Remove profiles on computer1 older than 1 day, don't remove administrator.  Do not confirm deletion

    .EXAMPLE
	    Remove-Profile -computername server1 -days 360 -exceptions ctxservice -whatif

        Uses Whatif switch to display what would happen if we ran the command.  Thus, lists profiles older than 360 days on server1 that aren't named ctxservice
    
    .FUNCTIONALITY
        Computers

    #>	
    [cmdletbinding(
        SupportsShouldProcess = $true,
        ConfirmImpact="High"
    )]
    param(
        [string[]]$computername="localhost",
        [validaterange(0,9999)][int]$days = 1,
        [string[]]$exceptions = $null,
        [string[]]$profiles = $null
    )
    
    #function to get profiles
    function Get-Profile {
        [cmdletbinding()]
        param(
            [string]$computername,
            [string[]]$exceptions = $null,
            [string[]]$profiles = $null
        )
    
        #function to convert array of strings into regex for paths to avoid
        function build-Regex {
            param([string[]]$items)
            $( foreach($item in $items){ "^$item$" } ) -join "|"
        }

        $date = get-date

        #test connection
        if(Test-Connection -ComputerName $computername -BufferSize 16 -count 2 -Quiet){
        
            #Check OS
            Try{
                $opSys = Get-WmiObject Win32_OperatingSystem -computername $computername | select -ExpandProperty version
            }
            Catch{
                Throw "Error: Could not obtain OS version WMI information from $computername"
                Return 
            }

            #Find XP profiles
            if ($opSys –like “5*”) {
                
                #define property that we will use to test exceptions / profile regexs against
                $property = "fullname"
            
                #get all profiles on computer using file system
                $allProfiles = Get-Childitem "\\$computername\c$\documents and settings\" -force | ?{$_.PSIsContainer}
            }

            #Find Vista + profiles
            if ($opSys –like “6*”) {
                
                #define property that we will use to test exceptions / profile regexs against
                $property = "localpath"
                
                Try{
                    #get all profiles on computer using WMI
                    $allProfiles = get-wmiobject -computername $computername -class win32_userprofile | ?{ $_.localpath -like "C:\users\*" } 
                }
                Catch{
                    Throw "Error gathering profile WMI information from $computername.  Be sure that WMI is functioning on this system and that it is running Windows Vista or Server 2008 or later"
                    Return
                }

            }

            #if specified, filter for profiles
            if($profiles){
                #build regex using provided profiles
                $profileRegex = build-Regex $profiles

                #test profiles against profiles regex
                $allProfiles = $allProfiles | ?{ $(split-path $_.$property -leaf) -match $profileRegex }
            }

            #if specified, filter exceptions
            if($exceptions){
                #build regex using provided exceptions
                $exceptionsRegex = build-Regex $exceptions

                #test profiles against exceptions regex
                $allProfiles = $allProfiles | ?{ $(split-path $_.$property -leaf) -notmatch $exceptionsRegex }
            }

            #Return results
            $allProfiles

        }
        else{
            Throw "Could not connect to $computername"
            Return
        }
    }

    #Get date for profile last access comparison
    $date = get-date
    
    #Add standard accounts to exclude unless explicitly instructed not to
    if( -not $DontExcludeStandardAccounts ){
        $exceptions += "Administrator", "LocalService", "NetworkService", "All Users", "Default User"
    }

    #loop through provided computers
    foreach($computer in $computername){
        
        #get all the profiles for this computer
        $profilesToRemove = Get-Profile -computername $computer -exceptions $exceptions -profiles $profiles -ErrorAction stop
        
        #if none returned, throw an error and move on to the next computer
        if(-not $profilesToRemove){
            Write-Error "Error: No profiles returned on $computer"
            Continue
        }

        #Get-Profiles returns a directoryinfo object for XP, use this to determine OS.
        if($profilesToRemove[0] -isnot [System.IO.DirectoryInfo]){ $opsys = 6 }
        else{ $opsys = 5 }

        #loop through profiles
        foreach($profile in $profilesToRemove){
        
            #Define path and last access time for profile
            if($opsys -eq 6){

                #Windows 7: convert localpath to remote path remote path.  Currently only handling profiles on C drive
                $path = $profile.localpath.replace("C:","\\$computer\C$")
                $lastAccess = ([WMI]'').ConvertToDateTime($profile.LastUseTime)

            }
            else{

                #Windows XP: define path
                $path = $profile.fullname
                $lastAccess = $profile.lastWriteTime
            }

            #Confirm we can reach $path
            Try {
                get-item $path -force -ErrorAction stop | out-null
            }
            Catch{
                #if we couldn't get the item, display an error and move on to the next profile
                Write-Error "Error: Could not get-item for $path"
                Continue
            }

            #If the profile is older than the days specified, remove it
            if($lastAccess -lt $date.AddDays(-$days)){
            
                #-confirm and -whatif support
                if($pscmdlet.shouldprocess("$path last accessed $lastAccess")){
                    
                    #build results object
                    $tempResult = "" | Select ComputerName, Path, lastAccess, Status
                   
                    Try{

                        if($opsys -eq 6){
                            #Windows Vista+: remove the profile using WMI
                            $profile.delete()
                        }
                        else{
                            #Windows XP: remove the profile using file system
                            Remove-Item $path -force -confirm:$false -recurse
                        }

                        #Add properties to results object
                        $tempResult.ComputerName = $computer
                        $tempResult.Path = $path
                        $tempResult.LastAccess = $lastAccess
                        $tempResult.Status = "No error"
                    }
                    Catch{
                        
                        #add properties to results object
                        $tempResult.ComputerName = $computer
                        $tempResult.Path = $path
                        $tempResult.LastAccess = $lastAccess
                        $tempResult.Status = "Error removing profile"
                        
                        #WMI delete method or file removal failed.  Write an error, move on to the next profile
                        Write-Error "Error: Could not delete $path last accessed $lastAccess"
                        Continue
                    }
                    
                    #display result
                    $tempResult
                }
            }
        }
    }