Function Invoke-CapsLockToggle
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
            HelpMessage="How many times should caps lock be toggled? (1-100)")]
        [ValidateRange(1, 100)]
        [int]
        $Amount = "5",

        [Parameter(Mandatory=$False,
            HelpMessage="How often should caps lock be toggled (in seconds)? (1-1800)")]
        [ValidateRange(1, 1800)]
        [int]
        $Interval = "200"
    )

    BEGIN {
        # Set $Value variable to the initial value of 0
        $Value = 0
    }
    PROCESS {
        if ($PSCmdlet.ShouldProcess("Caps Lock", "Toggle every $Interval seconds, $Amount times.")) {
            # Sets the while loop to run until the $val variable's value reaches $Amount
            while($Value -ne $Amount) {
                Set-LockToggle -CapsLock -Confirm:$False
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