<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
#>
function Get-PBChannelInfo
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        # The channel to get information for
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ParameterSetName='ChannelTag')]
        [ValidateNotNullOrEmpty()]
        [Alias("channel_tag")]
        [String]
        $ChannelTag
    )

    Process
    {
        Write-Verbose "Building the request body"
        $Body = @{
            "tag" = "$ChannelTag";
        }

        Write-Verbose "Invoking Invoke-PBAPI on the channel"
        Invoke-PBAPI -RelativePath '/channel-info' -Method Get -Body $Body
    }
}