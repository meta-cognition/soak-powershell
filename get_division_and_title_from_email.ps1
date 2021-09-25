import-module activedirectory
Remove-Item -path output.csv

$Credential = $host.ui.PromptForCredential("Need credentials", "Please enter your SOA user name and password.", "", "NetBiosUserName")

Import-Csv input.csv | ForEach {
	try{
		Get-ADUser -Credential $Credential -Server "soa.alaska.gov" -Filter "EmailAddress -eq '$($_.email)'" -Properties Division, Title |
		Select Division, Title |
		Export-CSV output.csv -Append -Encoding UTF8
	}catch{
		"[Unknown or Error]" | add-content -path output.csv
	}
}
