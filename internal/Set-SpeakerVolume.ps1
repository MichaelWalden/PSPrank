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
            HelpMessage='What volume would you like to set your speaker to?',
            ParameterSetName='SpecificVolume')]
        [ValidateRange(1,100)]
        [int]
        $Volume,

        [Parameter(Mandatory=$True,
            HelpMessage='Specify this switch to set volume to the max',
            ParameterSetName='MaxVolume')]
        [switch]
        $Max,

        [Parameter(Mandatory=$True,
            ParameterSetName='Mute')]
        [Alias('Mute')]
        [switch]
        $ToggleMute
    )

    BEGIN {
        if (-not $ToggleMute) {
            $FullVolumeSet = 1..50
            if ($PSBoundParameters.ContainsKey('Volume')) {
                # This method can only set in increments of 2. Divide the given volume by 2 (and round if needed)
                [int]$VolumeSetting = $Volume / 2
                $TrueVolume         = $VolumeSetting * 2
                $UpVolumeSet        = 1..$VolumeSetting
            }
        }
        $WScriptShell = New-Object -ComObject "wscript.shell"
    }
    PROCESS {
        if ($PSBoundParameters.ContainsKey('Volume') -and $PSCmdlet.ShouldProcess("$env:COMPUTERNAME", "Set-SpeakerVolume to $TrueVolume")) {
            # Turn volume to 0, so that we can set it to desired level
            $FullVolumeSet | ForEach-Object {$WScriptShell.SendKeys([char]174)}
            # Turn volume up to desired level
            $UpVolumeSet | ForEach-Object {$WScriptShell.SendKeys([char]175)}
        }
        if ($ToggleMute.IsPresent -and $PSCmdlet.ShouldProcess("$env:COMPUTERNAME", "Toggle mute")) {
            $WScriptShell.SendKeys([char]173)
        }
        if ($Max.IsPresent -and $PSCmdlet.ShouldProcess("$env:COMPUTERNAME", "Set-SpeakerVolume to Max")) {
            $FullVolumeSet | ForEach-Object {$WScriptShell.SendKeys([char]175)}
        }
    }
    END {
    }
}