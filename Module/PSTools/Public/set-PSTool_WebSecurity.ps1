<# 
 .SYNOPSIS 
 Set security protocol to Tls12 

.DESCRIPTION 
 Sometimes needed to be able to attach to a web API, changes the security to Tls12 

.EXAMPLE 
 set-PSTool_WebSecurity
Sets SecurityProtocol to Tls12 

.NOTES 
 Author: Mentaleak 

#>    

function set-PSTool_WebSecurity () {
 
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
}
