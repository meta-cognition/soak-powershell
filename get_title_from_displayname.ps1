import-module activedirectory

Import-Csv c:\Users\dmpannone-ou\Desktop\input.csv | ForEach {
Get-ADUser -Server "soa.alaska.gov" -Filter "DisplayName -eq '$($_.name)'" -Properties DisplayName, Title |
Select DisplayName, Title |
Export-CSV C:\Users\dmpannone-ou\Desktop\output.csv -Append -Encoding UTF8
}
