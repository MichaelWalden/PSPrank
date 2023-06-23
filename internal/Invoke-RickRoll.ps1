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
    param(
        [Parameter(Mandatory=$False,
            HelpMessage="Use this switch for maximum annoyance. Sets volume to 100% on every line.")]
        [switch]
        $AnnoyingMode
    )

    BEGIN {
        $Lyrics = @(
            "We're no strangers to love",
            "You know the rules and so do I",
            "A full commitment's what I'm thinking of",
            "You wouldn't get this from any other guy",
            "I just wanna tell you how I'm feeling",
            "Gotta make you understand",
            "Never gonna give you up",
            "Never gonna let you down",
            "Never gonna run around and desert you",
            "Never gonna make you cry",
            "Never gonna say goodbye",
            "Never gonna tell a lie and hurt you",
            "We've known each other for so long",
            "Your heart's been aching but you're too shy to say it",
            "Inside we both know what's been going on",
            "We know the game and we're gonna play it",
            "And if you ask me how I'm feeling",
            "Don't tell me you're too blind to see",
            "Never gonna give you up",
            "Never gonna let you down",
            "Never gonna run around and desert you",
            "Never gonna make you cry",
            "Never gonna say goodbye",
            "Never gonna tell a lie and hurt you",
            "Never gonna give you up",
            "Never gonna let you down",
            "Never gonna run around and desert you",
            "Never gonna make you cry",
            "Never gonna say goodbye",
            "Never gonna tell a lie and hurt you",
            "Ooh give you up",
            "Ooh give you up",
            "Ooh Never gonna give, never gonna give, give you up",
            "Ooh Never gonna give, never gonna give, give you up",
            "We've known each other for so long",
            "Your heart's been aching but you're too shy to say it",
            "Inside we both know what's been going on",
            "We know the game and we're gonna play it",
            "I just wanna tell you how I'm feeling",
            "Gotta make you understand",
            "Never gonna give you up",
            "Never gonna let you down",
            "Never gonna run around and desert you",
            "Never gonna make you cry",
            "Never gonna say goodbye",
            "Never gonna tell a lie and hurt you",
            "Never gonna give you up",
            "Never gonna let you down",
            "Never gonna run around and desert you",
            "Never gonna make you cry",
            "Never gonna say goodbye",
            "Never gonna tell a lie and hurt you",
            "Never gonna give you up",
            "Never gonna let you down",
            "Never gonna run around and desert you",
            "Never gonna make you cry",
            "Never gonna say goodbye",
            "Never gonna tell a lie and hurt you"
        )
    }
    PROCESS {
        if ($AnnoyingMode) {
            if ($PSCmdlet.ShouldProcess("$env:COMPUTERNAME")) {
                foreach ($Line in $Lyrics) {
                    # Set volume to max (100%) each line
                    Set-SpeakerVolume -Max
                    Invoke-Speech -Phrase $Line -Confirm:$False
                }
            }
        } else {
            if ($PSCmdlet.ShouldProcess("$env:COMPUTERNAME")) {
                # Set volume to max (100%) once
                Set-SpeakerVolume -Max
                Invoke-Speech -Phrase $Lyrics -Confirm:$False
            }
        }
    }
    END {
        # Set the speaker back to a reasonable level (40%)
        # It's overly complicated to determine the original level and if the sound was muted. Besides, it is a prank.
        Set-SpeakerVolume -Volume "40"
    }
}