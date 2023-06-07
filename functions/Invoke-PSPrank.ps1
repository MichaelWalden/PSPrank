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
            HelpMessage='What Computer name would you like to target?')]
        [Alias('Prank')]
        [ValidateLength(3,30)]
        [string[]]
        $ComputerName
    )

    BEGIN
    {
        Write-Verbose "Beginning $($MyInvocation.Mycommand)"
        Write-Verbose "Deleting $Logname"
        Remove-Item $LogName -ErrorActionSilentlyContinue
    }

    PROCESS
    {
        Write-Verbose "Processing $($MyInvocation.Mycommand)"

        ForEach ($Computer in $ComputerName) {
            Write-Verbose "Processing $Computer"
            IF ($pscmdlet.ShouldProcess($Computer)) {
                # use $Computer here
            }
        }
    }
    END
    {
        Write-Verbose "Ending $($MyInvocation.Mycommand)"
    }
}