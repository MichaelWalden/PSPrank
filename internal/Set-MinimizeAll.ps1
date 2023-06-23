Function Set-MinimizeAll
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
        $Shell = New-Object -ComObject 'Shell.Application'
    }
    PROCESS {
        if ($PSCmdlet.ShouldProcess("All Windows", "Minimize")) {
            $Shell.MinimizeAll()
        }
    }
    END {
    }
}