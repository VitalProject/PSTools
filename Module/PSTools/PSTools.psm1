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
. $PSScriptRoot\public\compare-object_pstool.ps1
. $PSScriptRoot\public\convertto-clixml_PSTool.ps1
. $PSScriptRoot\public\Get-functions_PSTool.ps1
. $PSScriptRoot\public\get-timestamp_PSTool.ps1
. $PSScriptRoot\public\get-usedCommands_PSTool.ps1
. $PSScriptRoot\public\set-WebSecurity_PSTool.ps1
Export-ModuleMember compare-object_pstool
Export-ModuleMember convertto-clixml_PSTool
Export-ModuleMember Get-functions_PSTool
Export-ModuleMember get-timestamp_PSTool
Export-ModuleMember get-usedCommands_PSTool
Export-ModuleMember set-WebSecurity_PSTool
