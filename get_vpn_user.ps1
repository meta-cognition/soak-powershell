param ( $Show )
if ( !$Show ) 
{
    PowerShell -NoExit -File $MyInvocation.MyCommand.Path 1
    return
}

import-module activedirectory
Get-ADGroupMember DOT-VPN | Where-Object { $_.objectClass -eq 'user' } |
Get-ADUser -Properties * | Select DisplayName, Division, Title, Department, pcn|

Export-CSV output.csv -Append -Encoding UTF8

Write-Output 'Script Completed'
