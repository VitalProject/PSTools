param([switch]$NoVersionCheck)

#Is module loaded; if not load
if ((Get-Module PSTools)){return}
    $psv = $PSVersionTable.PSVersion

    #verify PS Version
    if ($psv.Major -lt 5 -and !$NoVersionWarn) {
        Write-Warning ("PSTools is listed as requiring 5; you have version $($psv).`n" +
        "Visit Microsoft to download the latest Windows Management Framework `n" +
        "To suppress this warning, change your include to 'Import-Module PSTools -NoVersionCheck `$true'.")
        return
    }
. $PSScriptRoot\public\Get-PSTool_functions.ps1
. $PSScriptRoot\private\get-PSTool_usedCommands.ps1
. $PSScriptRoot\private\set-PSTool_WebSecurity.ps1
Export-ModuleMember Get-PSTool_functions
Export-ModuleMember get-PSTool_usedCommands
Export-ModuleMember set-PSTool_WebSecurity
