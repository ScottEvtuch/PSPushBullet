<#
.Synopsis
   Gets devices from the associated Pushbullet account
.DESCRIPTION
   Uses "Invoke-PBAPI" to retrieve device objects
.EXAMPLE
   Get-PBDevices | where type -EQ "windows"
#>
function Get-PBDevices
{
    [CmdletBinding()]
    [Alias()]
    Param()

    Process
    {
        # Invoke the API
        $Response = Invoke-PBAPI -RelativePath '/devices' -Method Get

        # Return the response
        return $Response.devices
    }
}