
<#PSScriptInfo

.VERSION 1.0

.GUID 73682885-3755-49b2-abbe-6ddfe39cbbaf

.AUTHOR timmcmic@microsoft.com

.COMPANYNAME 

.COPYRIGHT 

.TAGS 

.LICENSEURI 

.PROJECTURI 

.ICONURI 

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS 

.EXTERNALSCRIPTDEPENDENCIES 

.RELEASENOTES


#>

<# 

.DESCRIPTION 
 This script allows a user to find an object and purge single objects from AD Connect and resync. 

#> 
[cmdletbinding()]

Param
(
    #Define parameters to find user in local active directory.
    [Parameter(Mandatory = $false)]
    [string]$objectMailAddress="",
    #Define attributes for Active Directory connection.
    [Parameter(Mandatory = $true)]
    [string]$globalCatalogServer,
    [Parameter(Mandatory = $false)]
    [pscredential]$globalCatalogCredential=$NULL,
    #Define general paramters.
    [Parameter(Mandatory = $false)]
    [string]$logPath
)
Function Out-LogFile
     {
        [cmdletbinding()]

        Param
        (
            [Parameter(Mandatory = $true)]
            $String,
            [Parameter(Mandatory = $false)]
            [boolean]$isError=$FALSE,
            [Parameter(Mandatory = $false)]
            [boolean]$isAudit=$FALSE
        )
    
        # Get the current date

        [string]$date = Get-Date -Format G
    
        # Build output string
        #In this case since I abuse the function to write data to screen and record it in log file
        #If the input is not a string type do not time it just throw it to the log.

        if ($string.gettype().name -eq "String")
        {
            [string]$logstring = ( "[" + $date + "] - " + $string)
        }
        else 
        {
            $logString = $String
        }
        
        # Write everything to our log file and the screen

        $logstring | Out-File -FilePath $global:LogFile -Append
    
        #Write to the screen the information passed to the log.

        if ($string.gettype().name -eq "String")
        {
            Write-Host $logString
        }
        else 
        {
            write-host $logString | select-object -expandProperty *
        }

        #If the output to the log is terminating exception - throw the same string.

        if ($isError -eq $TRUE)
        {
            #Ok - so here's the deal.
            #By default error action is continue.  IN all my function calls I use STOP for the most part.
            #In this case if we hit this error code - one of two things happen.
            #If the call is from another function that is not in a do while - the error is logged and we continue with exiting.
            #If the call is from a function in a do while - write-error rethrows the exception.  The exception is caught by the caller where a retry occurs.
            #This is how we end up logging an error then looping back around.

            write-error $logString

            #Now if we're not in a do while we end up here -> go ahead and create the status file this was not a retryable operation and is a hard failure.

            if ($global:ThreadNumber -gt 0)
            {
                out-statusFile -threadNumber $global:ThreadNumber
            }

            disable-allPowerShellSessions

            if ($isAudit -eq $FALSE)
            {
                Start-ArchiveFiles -isSuccess:$FALSE -logFolderPath $logFolderPath
            }
            exit
        }
    }


