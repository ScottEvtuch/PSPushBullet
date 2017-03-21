<#
.Synopsis
   Invokes the Pushbullet API
.DESCRIPTION
   Uses "Invoke-RestMethod" to call the Pushbullet API at $PBAPIUrl
.EXAMPLE
   Invoke-PBAPI -RelativePath '/pushes' -Method Post -Body $Push
#>
function Invoke-PBAPI
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        # Relative path for the API
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]
        $RelativePath,

        # HTTP method
        [Parameter(Mandatory=$true)]
        [Microsoft.PowerShell.Commands.WebRequestMethod]
        $Method,
        
        # Hashtable of request properties
        [Parameter()]
        [System.Collections.Hashtable]
        $Body
    )

    Process
    {
        Write-Verbose "Building headers from API key"
        $Headers = @{
            'Access-Token' = $PBAPIKey;
        }

        if ($Method -ne 'Get')
        {
            Write-Verbose "Converting request body to JSON"
            $ThisBody = $Body | ConvertTo-Json
        }
        else
        {
            $ThisBody = $Body
        }

        Write-Verbose "Invoking the API"
        try
        {
            $Response = Invoke-RestMethod -Headers $Headers -Method $Method -Uri "$PBAPIUrl$RelativePath" -Body $ThisBody -ContentType 'application/json'
        }
        catch
        {
            throw "API Request failed: $_"
        }

        Write-Verbose "Returning the API response"
        return $Response
    }
}