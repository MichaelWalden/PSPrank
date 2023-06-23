Function Invoke-PSPrank
{
<#
    .SYNOPSIS
        This function runs a prank based on the parameters specified.

    .DESCRIPTION
        Choose from a list of pranks to run and execute.

    .EXAMPLE
        Invoke-PSPrank -Prank "RickRoll"

    .EXAMPLE
        Invoke-PSPrank -Prank "Minimize"

    .PARAMETER Prank
        The prank to run. Choose from the following: RickRoll, Minimize.

    .INPUTS
        Input is from command line or called from a scheduled task or script.

    .OUTPUTS
        Most pranks should not have any file or command line output.

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
            HelpMessage='What prank would you like to use?',
            Position="0")]
        #[Alias('Prank')]
        [ValidateSet("RickRoll", "Minimize")]
        [string]
        $Prank
    )

    BEGIN {
        Write-Verbose "Beginning $($MyInvocation.Mycommand)"
    }
    PROCESS {
        switch ($Prank) {
            "RickRoll" {
                if ($PSCmdlet.ShouldProcess("$env:COMPUTERNAME","Invoke-RickRoll")) {
                    Invoke-RickRoll -Confirm:$False
                }
            }
            "Minimize" {
                if ($PSCmdlet.ShouldProcess("$env:COMPUTERNAME","Invoke-Minimizing")) {
                    Invoke-Minimizing -Confirm:$False
                }
            }
            Default {
                throw "$Prank does not appear to be a supported prank."
            }
        }
    }
    END {
        Write-Verbose "Ending $($MyInvocation.Mycommand)"
    }
}