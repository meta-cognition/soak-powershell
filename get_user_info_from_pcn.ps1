import-module activedirectory

Remove-Item -path C:\Users\dmpannone-ou\Desktop\output.csv
Add-Content C:\Users\dmpannone-ou\Desktop\output.csv -Value $("SoAK User ID, Name, Title, Supervisor, Telephone Number, Fax Number, Department, Division")
Import-Csv c:\Users\dmpannone-ou\Desktop\input.csv | ForEach {

$l = Get-ADUser -Filter "pcn -eq '$($_.pcn)' -and Enabled -eq 'True'" -Properties CN, DisplayName, Title, soaPCN, EmailAddress, OfficePhone, Division, Department, Fax | Select CN, DisplayName, Title, soaPCN, EmailAddress, OfficePhone, Division, Department, Fax

$m = Get-ADUser -Filter "pcn -eq '$($_.pcn)' -and Enabled -eq 'True'" -Properties Manager | Select Manager

$n = $m -split ',', 2

$o = $n -split '='

$p = $o[2]

$q = Get-ADUser -Filter "CN -eq '$($p)'" -Properties DisplayName | Select DisplayName

Add-Content C:\Users\dmpannone-ou\Desktop\output.csv -Value $("`"" + $l.CN + "`"" + "," + "`"" + $l.DisplayName + "`"" + "," + "`"" + $l.Title + "`"" + "," + "`"" + $q.DisplayName + "`"" + "," + "`"" + $l.OfficePhone + "`"" + "," + "`"" + $l.Fax + "`"" + "," + "`"" + $l.Department + "`"" + "," + "`"" + $l.Division + "`"" )

}

Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
   