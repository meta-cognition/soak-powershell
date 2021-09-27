# Powershell script to extract DOT-VPN group members from Dustin Grimes:
# 
# 
# • This powershell code can be run on the SOA/Exchange terminal server.
# • The file path ".\dotvpn.csv" may require some tweaking depending on what path you run the script from.
#	 o .\ refers to the current path script is being run from, ".\users\[insertusneramehere]\desktop" should put the .csv file on the desktop of the user.
# • the "memberof" can be removed if you don't need that info.  helpful to see in all-in-one report if the user is RSA SecurID 2FA vs password protected VPN.
# • # is the comment character.  remove or add from a string to force powershell to run/ignore those lines
# 
# BTW I sent this also to the MADS team members who probably get this question from time to time.

--
####
##run this block first##
####
$import-module Activedirectory
#adjust filepath if having difficulty 
$filepath=".\dotvpn.csv"
#$filepath=".\users\[yourusernamehere]\desktop\dotvpn. csv"

####
##run the code block depending on type of report##
####

##users in dot-vpn or dot-vpn-rsa##
$searchscope="ou=dot,ou=state departments,dc=soa,dc=alaska,dc=gov"
$users=get-aduser -filter * -properties * -searchbase $searchscope | where {$_.memberof -match "-vpn"} | select name,emailaddress,memberof
$users | export-csv $filepath

##users in dot-vpn only##
import-module activedirectory
$searchscope="ou=dot,ou=state departments,dc=soa,dc=alaska,dc=gov"
$users=get-aduser -filter * -properties * -searchbase $searchscope | where {($_.memberof -match "-vpn") -and ($_.memberof -notmatch "rsa")} | select name,emailaddress,memberof
$users | export-csv $filepath

##users in dot-vpn-rsa only##
import-module activedirectory
$searchscope="ou=dot,ou=state departments,dc=soa,dc=alaska,dc=gov"
$users=get-aduser -filter * -properties * -searchbase $searchscope | where {($_.memberof -match "-rsa")} | select name,emailaddress,memberof
$users | export-csv $filepath

