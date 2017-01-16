<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
#>
function Send-PBPush
{
    [CmdletBinding(DefaultParameterSetName='UserDevices', 
                  SupportsShouldProcess=$true,
                  ConfirmImpact='Medium')]
    [Alias()]
    Param
    (
        # Device to send the push to
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        $Push,

        # Device to send the push to
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ParameterSetName='UserDevice')]
        [ValidateNotNullOrEmpty()]
        [Alias("device_iden")]
        $DeviceID,

        # Email to send the push to
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ParameterSetName='Email')]
        [ValidateNotNullOrEmpty()]
        $Email,

        # Email to send the push to
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ParameterSetName='ChannelTag')]
        [ValidateNotNullOrEmpty()]
        [Alias("channel_tag")]
        $ChannelTag,

        # Email to send the push to
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ParameterSetName='Client')]
        [ValidateNotNullOrEmpty()]
        [Alias("client_id")]
        $ClientID
    )

    Process
    {
        if ($pscmdlet.ShouldProcess("Push", "Send"))
        {
            # Invoke the API
            Invoke-PBAPI -RelativePath '/pushes' -Method Post -Body $Push
        }
    }
}