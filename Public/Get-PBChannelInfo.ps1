<#
.Synopsis
   Gets information on a Pushbullet channel
.DESCRIPTION
   Uses "Invoke-PBAPI" to pull channel information for a specific channel
.EXAMPLE
   Get-PBChannelInfo -ChannelTag "ExampleChannel"
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