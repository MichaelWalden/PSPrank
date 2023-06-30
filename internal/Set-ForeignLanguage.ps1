Function Set-ForeignLanguage
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
    )

    BEGIN {
        # Check for running as administrator.
        # Unfortunately needed for the scheduled job to revert the settings on next login.
        # Probably need to add a switch to not set this job, as then it could be run without admin
        if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
            throw "This function must be run as administrator"
        } else {
            Write-Verbose "Function is being run as administrator."
        }

        try {
            Import-Module -Name International -ErrorAction Stop
        } catch {
            throw "The required module, International, could not be imported."
        }

        # Get the current language so that we can make sure it is set to something different
        # Check for current language override (if present):
        $LanguageOverride = (Get-WinUILanguageOverride).Name

        if ([string]::IsNullOrWhiteSpace($LanguageOverride)) {
            Write-Verbose "No language override currently detected."
            $CurrentLanguage = (Get-WinSystemLocale).Name
        } else {
            # Only 1 language override can be present at a time, so the override value is the current language.
            $CurrentLanguage = $LanguageOverride
        }

        # List of langauges to try to use. Tried to get a good variety of languages
        $Languages = [System.Collections.ArrayList]@(
                        "am-ET",  # Amharic - Ethiopia
                        "as-IN",  # Assamese
                        "chr-US", # Cherokee - United States
                        "zh-CN",  # Chinese - People's Republic of China
                        "et-EE",  # Estonian
                        "el-GR",  # Greek
                        "he-IL",  # Hebrew
                        "km-KH",  # Khmer
                        "lo-LA",  # Lao
                        "ms-MY",  # Malay - Malaysia
                        "mi-NZ",  # Maori - New Zealand
                        "ro-RO",  # Romanian
                        "si-LK",  # Sinhalese - Sri Lanka
                        "vi-VN",  # Vietnamese
                        "zu-ZA"   # Zulu
        )

        # If needed, remove the current language from the language list.
        # This doesn't work with every language, but should work well enough for our purposes.
        if ($Languages -contains $CurrentLanguage) {
            $Languages.Remove($CurrentLanguage)
        }

        # Pick a random language
        $SetLanguage = $Languages | Get-Random

        # Variables needed for the self deleting scheduled job that will reset the language on next logout.
        $JobName     = "Reset Language"
        $User        = "{0}\{1}" -f $env:USERDOMAIN, $env:USERNAME
        $Trigger     = New-JobTrigger -AtLogOn -User $User
        $ScriptBlock = {
            Set-WinUILanguageOverride
            Unregister-ScheduledJob -Name $JobName -Force
        }
        $JobParams   = @{
            Name        = $JobName
            Trigger     = $Trigger
            ScriptBlock = $ScriptBlock
            Confirm     = $False
        }
    }
    PROCESS {
        if ($PSCmdlet.ShouldProcess("$env:COMPUTERNAME", "Set Random Langauge")) {
            Set-WinUILanguageOverride -Language $SetLanguage
            Write-Verbose "User must log out and back in for language change to $SetLanguage to take effect."
            # Set scheduled task to remove the override on next login, then unregister itself.
            Register-ScheduledJob @JobParams | Out-Null
            Write-Verbose "Scheduled job registered to remove language changes on next logon."
        }
    }
    END {
    }
}