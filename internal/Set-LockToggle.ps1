Function Set-LockToggle
{
<#
    .NOTES
        Version: 0.1
        Author: Michael Waldenmaier
        Creation Date: 2023.06.29
        Purpose/Change: Initial script development
#>
    [CmdletBinding(SupportsShouldProcess=$True,ConfirmImpact='Low')]
    param
    (
    [Parameter(Mandatory=$False)]
    [switch]
    $CapsLock,

    [Parameter(Mandatory=$False)]
    [switch]
    $NumLock,

    [Parameter(Mandatory=$False)]
    [switch]
    $ScrollLock
    )

    BEGIN {
        if (-not $CapsLock -and -not $NumLock -and -not $ScrollLock) {
            throw "At least one parameter must be specified with this command."
        }

        $WScriptShell = New-Object -ComObject "wscript.shell"
    }
    PROCESS {
        if ($CapsLock.IsPresent -and $PSCmdlet.ShouldProcess("$env:COMPUTERNAME", "Toggle Caps Lock")) {
            $WScriptShell.SendKeys("{CAPSLOCK}")
        }
        if ($NumLock.IsPresent -and $PSCmdlet.ShouldProcess("$env:COMPUTERNAME", "Toggle Num Lock")) {
            $WScriptShell.SendKeys("{NUMLOCK}")
        }
        if ($ScrollLock.IsPresent -and $PSCmdlet.ShouldProcess("$env:COMPUTERNAME", "Toggle Scroll Lock")) {
            # Scroll lock is still a thing? What does this even do?
            $WScriptShell.SendKeys("{SCROLLLOCK}")
        }
    }
    END {
    }
}