<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
#>
function New-PBPush
{
    [CmdletBinding(DefaultParameterSetName='Note')]
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
        $FileURL
    )

    Process
    {
        switch ($PSCmdlet.ParameterSetName)
        {
            'Note'
            {
                $Push = @{
                    'type' = 'note';
                    'title' = $Title;
                    'body' = $Body;
                }
            }
            'Link'
            {
                $Push = @{
                    'type' = 'link';
                    'title' = $Title;
                    'body' = $Body;
                    'url' = $URL;
                }
            }
            'File'
            {
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

        return $Push
    }
}