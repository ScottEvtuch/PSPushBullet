﻿<#
.Synopsis
   Sends a push to the provided destination
.DESCRIPTION
   Uses "Invoke-PBAPI" to send a push
.EXAMPLE
   Send-PBPush -Push (New-PBPush -Title "Example" -Body "Push!")
.EXAMPLE
   New-PBPush -Title "Example" -Body "Push!" | Send-PBPush -ChannelTag "ExampleChannel"
#>
function Send-PBPush
{
    [CmdletBinding(DefaultParameterSetName='UserDevices', 
                  SupportsShouldProcess=$true,
                  ConfirmImpact='Medium')]
    [Alias()]
    Param
    (
        # The push
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        $Push,
        
        # Device to send the push to
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ParameterSetName='UserDevice')]
        [ValidateNotNullOrEmpty()]
        [Alias("iden")]
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
        # Clone the push in case we pipe multiple targets
        Write-Debug "Cloning the input Push object"
        $ThisPush = $Push.Clone()

        # Build the request body
        switch ($PSCmdlet.ParameterSetName)
        {
            'UserDevice'
            {
                Write-Verbose "Adding the device_iden to the push object"
                $ThisPush.Add("device_iden",$DeviceID)
            }
            'ChannelTag'
            {
                Write-Verbose "Adding the channel_tag to the push object"
                $ThisPush.Add("channel_tag",$ChannelTag)
            }
            # TODO: Other targets
            Default
            {
                Write-Verbose "Default push to all devices"
            }
        }

        if ($pscmdlet.ShouldProcess("Push: $($Push.title)", "Send"))
        {
            Write-Verbose "Invoking Invoke-PBAPI on the Push object"
            Invoke-PBAPI -RelativePath '/pushes' -Method Post -Body $ThisPush
        }
    }
}