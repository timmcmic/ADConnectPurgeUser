
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
    [Parameter(Mandatory = $false)]
    [string]$objectMailAddress
)


