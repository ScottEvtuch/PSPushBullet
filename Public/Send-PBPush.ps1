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