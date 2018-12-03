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
