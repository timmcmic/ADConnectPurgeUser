
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


