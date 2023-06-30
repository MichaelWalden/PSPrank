Function Invoke-PSPrank
{
<#
    .SYNOPSIS
        This function runs a prank based on the parameters specified.

    .DESCRIPTION
        Choose from a list of pranks to run and execute.

    .EXAMPLE
        Invoke-PSPrank -Prank "RickRoll"

        Sets volume to 100% and reads out the lyrics with the built in speech synthesizer.
        For that special someone in your life.
    .EXAMPLE
        Invoke-PSPrank -Prank "Minimize"

        Minimizes all screens 6 times with an interval of 30 seconds between each minimize.
        For your coworker who's screen in always cluttered. Help them clean it up!
    .EXAMPLE
        Invoke-PSPrank -Prank "CapsLock"

        Toggles caps lock 5 times with an interval of 200 seconds between each toggle.
        For that one friend that likes to yell all the time.
    .EXAMPLE
        Invoke-PSPrank -Prank "NumLock"

        Toggles num lock 3 times with an interval of 600 seconds between each toggle.
        For the accountants in your life.
    .PARAMETER Prank
        The prank to run. Choose from the following: RickRoll, Minimize, CapsLock, NumLock.

    .INPUTS
        Input is from command line or called from a scheduled task or script.

    .OUTPUTS
        Most pranks should not have any file or command line output.

    .NOTES
        Version: 0.2
        Author: Michael Waldenmaier
        Creation Date: 2023.06.06
        Purpose/Change: Update to include more pranks and better help text.
#>
    [CmdletBinding(SupportsShouldProcess=$True,ConfirmImpact='Low')]
    param
    (
        [Parameter(Mandatory=$True,
            HelpMessage='What prank would you like to use?',
            Position="0")]
        #[Alias('Prank')]
        [ValidateSet("RickRoll", "Minimize", "CapsLock", "NumLock")]
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
            "CapsLock" {
                if ($PSCmdlet.ShouldProcess("$env:COMPUTERNAME","Invoke-CapsLockToggle")) {
                    Invoke-CapsLockToggle -Confirm:$False
                }
            }
            "NumLock" {
                if ($PSCmdlet.ShouldProcess("$env:COMPUTERNAME","Invoke-NumLockToggle")) {
                    Invoke-NumLockToggle -Confirm:$False
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