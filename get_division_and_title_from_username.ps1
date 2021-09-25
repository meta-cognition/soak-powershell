import-module activedirectory
Remove-Item -path output.csv

Import-Csv input.csv | ForEach {
	try{
		Get-ADUser -Server "soa.alaska.gov" $($_.username) -Properties Division, Title |
		Select Division, Title |
		Export-CSV output.csv -Append -Encoding UTF8
	}catch{
		"[Unknown]" | add-content -path output.csv
	}
}
