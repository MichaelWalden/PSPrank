Function Invoke-RickRoll
{
<#
    .NOTES
        Version: 0.1
        Author: Michael Waldenmaier
        Creation Date: 2023.06.22
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
        if ($PSCmdlet.ShouldProcess("$env:COMPUTERNAME","Invoke-RickRoll")) {

        }
    }
    END {
        Write-Verbose "Ending $($MyInvocation.Mycommand)"
    }
}