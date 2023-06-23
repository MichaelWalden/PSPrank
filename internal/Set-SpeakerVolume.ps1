Function Set-SpeakerVolume
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
            HelpMessage='What volume would you like to set your speaker to?')]
        [ValidateRange(1,100)]
        [int]
        $Volume,

        [Parameter(Mandatory=$False)]
        [switch]
        $ToggleMute
    )

    BEGIN {
        Write-Verbose "Beginning $($MyInvocation.Mycommand)"
        # This method can only set in increments of 2. Divide the given volume by 2 (and round if needed)
        [int]$VolumeSetting = $Volume / 2
        $TrueVolume         = $VolumeSetting * 2
        $WScriptShell       = New-Object -ComObject "wscript.shell"
        $DownVolumeSet      = 1..50
        $UpVolumeSet        = 1..$VolumeSetting
    }
    PROCESS {
        if ($ToggleMute.IsPresent -and $PSCmdlet.ShouldProcess("$env:COMPUTERNAME", "Toggle mute")) {
            $WScriptShell.SendKeys([char]173)
        }
        if ($PSCmdlet.ShouldProcess("$env:COMPUTERNAME")) {
            # Turn volume to 0, so that we can set it to desired level
            $DownVolumeSet | ForEach-Object {$WScriptShell.SendKeys([char]174)}
            # Turn volume up to desired level
            $UpVolumeSet | ForEach-Object {$WScriptShell.SendKeys([char]175)}
            Write-Verbose "Volume set to ($TrueVolume)"
        }
    }
    END {
        Write-Verbose "Ending $($MyInvocation.Mycommand)"
    }
}