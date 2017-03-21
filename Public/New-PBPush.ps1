<#
.Synopsis
   Creates a new push, and optionally pushes it
.DESCRIPTION
   Creates a hashtable of properties necessary for sending to "Send-PBPush"
.EXAMPLE
   New-PBPush -Title "Example" -Body "Push!"
#>
function New-PBPush
{
    [CmdletBinding(DefaultParameterSetName='Note', 
                  SupportsShouldProcess=$true,
                  ConfirmImpact='Medium')]
    [Alias()]
    Param
    (
        # Title for the push
        [Parameter(ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='Note')]
        [Parameter(ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='Link')]
        [String]
        $Title,

        # Body for the push
        [Parameter(ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='Note')]
        [Parameter(ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='Link')]
        [Parameter(ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='File')]
        [String]
        $Body,

        # URL for the push
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='Link')]
        [ValidateNotNullOrEmpty()]
        [String]
        $URL,

        # File name for the push
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='File')]
        [ValidateNotNullOrEmpty()]
        [Alias("file_name")]
        [String]
        $FileName,

        # File MIME type for the push
        [Parameter(ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='File')]
        [Alias("file_type")]
        [String]
        $FileType,

        # File URL for the push
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='File')]
        [ValidateNotNullOrEmpty()]
        [Alias("file_url")]
        [String]
        $FileURL,

        # Immediately send the push to default devices
        [Parameter()]
        [Switch]
        $Send = $false
    )

    Process
    {
        switch ($PSCmdlet.ParameterSetName)
        {
            'Note'
            {
                Write-Verbose "Creating object for Note push"
                $Push = @{
                    'type' = 'note';
                    'title' = $Title;
                    'body' = $Body;
                }
            }
            'Link'
            {
                Write-Verbose "Creating object for Link push"
                $Push = @{
                    'type' = 'link';
                    'title' = $Title;
                    'body' = $Body;
                    'url' = $URL;
                }
            }
            'File'
            {
                Write-Verbose "Creating object for File push"
                $Push = @{
                    'type' = 'file';
                    'body' = $Body;
                    'file_name' = $FileName;
                    'file_type' = $FileType;
                    'file_url' = $FileURL;
                }
            }
            Default {throw "Bad ParameterSet"}
        }

        if ($Send)
        {
            if ($pscmdlet.ShouldProcess("Push: $($Push.title)", "Send"))
            {
                Write-Verbose "Invoking Send-PBPush on new push object"
                Send-PBPush -Push $Push
            }
        }
        else
        {
            Write-Verbose "Outputting the push object"
            Write-Output $Push
        }        
    }
}