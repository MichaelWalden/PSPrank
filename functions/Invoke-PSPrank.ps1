Function Invoke-PSPrank
{
<#
    .SYNOPSIS
        Describe the function here

    .DESCRIPTION
        Describe the function in more detail

    .EXAMPLE
        Give an example of how to use it

    .EXAMPLE
        Give another example of how to use it

    .PARAMETER ComputerName
        The Computer name to query. Just one.

    .INPUTS
        Input is from command line or called from a script.

    .OUTPUTS
        This will output the logfile.

    .NOTES
        Version: 0.1
        Author: Michael Waldenmaier
        Creation Date: 2023.06.06
        Purpose/Change: Initial script development
#>
    [CmdletBinding(SupportsShouldProcess=$True,ConfirmImpact='Low')]
    param
    (
        [Parameter(Mandatory=$True,
            HelpMessage='What prank would you like to use?')]
        #[Alias('Prank')]
        [ValidateSet("RickRoll")]
        [string]
        $Prank
    )

    BEGIN {
        Write-Verbose "Beginning $($MyInvocation.Mycommand)"
    }
    PROCESS {
        if ($PSCmdlet.ShouldProcess("$env:COMPUTERNAME","Invoke-PSPrank")) {
            switch ($Prank) {
                "RickRoll" {
                    Invoke-RickRoll -confirm:$false
                }
                Default {
                    throw "$Prank does not appear to be a supported prank."
                }
            }
        }
    }
    END {
        Write-Verbose "Ending $($MyInvocation.Mycommand)"
    }
}