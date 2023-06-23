Function Invoke-Speech
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
        [Parameter(Mandatory=$True,
            HelpMessage='What phrase would you like to have spoken?',
            Position="0")]
        [string[]]
        $Phrase
    )

    BEGIN {
        Add-Type -AssemblyName System.Speech
        $Speech = New-Object System.Speech.Synthesis.SpeechSynthesizer
    }
    PROCESS {
        foreach ($Line in $Phrase) {
            if ($PSCmdlet.ShouldProcess("$Line")) {
                $Speech.Speak($Line)
            }
        }
    }
    END {
    }
}