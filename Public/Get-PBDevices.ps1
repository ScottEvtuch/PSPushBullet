<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
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