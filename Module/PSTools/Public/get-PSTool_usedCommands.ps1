function get-PSTool_usedCommands () {
 <# 
 .PARAMETER filePath 
 string Parameter_filePath=filePath is a mandatory parameter of type string 

#>    

	param(
		[Parameter(mandatory = $true)] [string]$filePath
	)
	$file = Get-Item -Path $filePath
	$fileData = Get-Content $filePath
	$commandList = Get-Command | Where-Object { $_.Name -notmatch ":" -and $_.Source -notlike "Microsoft.Powershell.*" -and $_.Source -ne "" }
	$mehCommandList = Get-Command | Where-Object { $_.Name -notmatch "-" }
	$FoundCommands = @()
	$mehFoundCommands = @()
	$activeline = 0
	foreach ($line in $fileData)
	{
		$activeline++
		Write-Progress -Status "Reading $($file.name)" -Activity "Line $activeline / $($fileData.count)" -PercentComplete (100 * ($activeline / $fileData.count))
		#write-host $line
		$upline = $line.ToUpper()
		#write-host $upline
		foreach ($command in $commandList) {
			$commandName = "$($command.name.ToUpper())"
			#write-host $upline
			if ($upline -match [regex]::Escape($commandName))
			{

				if (("$($upline)"[(("$($upline)".IndexOf("$commandName")) + "$commandName".Length)] -notmatch '^[a-zA-Z0-9]+$') -and ("$($upline)"[("$($upline)".IndexOf("$commandName")) - 1] -notmatch '^[a-zA-Z0-9]+$'))
				{
					if ($mehCommandList | Where-Object { $_.Name -eq $command.Name }) {
						#write-host "$($command.Name): $line" -ForegroundColor "White"

						if ($mehFoundCommands | Where-Object { $_.CommandName -eq "$($command.Name)" })
						{
							($mehFoundCommands | Where-Object { $_.CommandName -eq "$($command.Name)" }).lines += "`n$($line.trim())"
						}
						else {
							$CommandObject = [pscustomobject]@{
								CommandName = $command.Name
								Module = $command.Source
								Version = $command.Version
								lines = "$($line.trim())"
							}
							$mehFoundCommands += $CommandObject
						}

					} else {
						#write-host "$($command.Name): $line" -ForegroundColor "Green"
						if ($FoundCommands | Where-Object { $_.CommandName -eq "$($command.Name)" })
						{
							($FoundCommands | Where-Object { $_.CommandName -eq "$($command.Name)" }).lines += "`n$($line.trim())"
						}
						else {
							$CommandObject = [pscustomobject]@{
								CommandName = $command.Name
								Module = $command.Source
								Version = $command.Version
								lines = "$($line.trim())"
							}
							$FoundCommands += $CommandObject
						}
					}

				}

			}
		}
	}
	Write-Progress -Activity "Complete" -Completed
	return [pscustomobject]@{
		GoodCommands = $FoundCommands
		MehCommands = $mehFoundCommands
	}

}
