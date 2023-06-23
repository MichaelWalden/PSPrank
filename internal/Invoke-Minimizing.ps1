Function Invoke-Minimizing
{
<#
    .NOTES
        Version: 0.1
        Author: Michael Waldenmaier
        Creation Date: 2023.06.22
        Purpose/Change: Initial script development
#>
    [CmdletBinding(SupportsShouldProcess=$True,ConfirmImpact='Low')]
    param(
        [Parameter(Mandatory=$False,
            HelpMessage="How many times should all windows minimize?")]
        [ValidateRange(1, 100)]
        [int]
        $Amount = "6",

        [Parameter(Mandatory=$False,
            HelpMessage="How often should all windows minimize (in seconds)?")]
        [ValidateRange(1, 1800)]
        [int]
        $Interval = "30"
    )

    BEGIN {
        # Set $Value variable to the initial value of 0
        $Value = 0
    }
    PROCESS {
        if ($PSCmdlet.ShouldProcess("All Windows", "Minimize every $Interval seconds, $Amount times.")) {
            # Sets the while loop to run until the $val variable's value reaches 3
            while($Value -ne $Amount) {
                Set-MinimizeAll -Confirm:$False
                # Increment the $Value variable by 1
	            $Value++
                # Print the current value of the $val variable
	            Write-Verbose "Executed $Value times out of $Amount."
                Start-Sleep $Interval
            }
        }
    }
    END {
    }
}