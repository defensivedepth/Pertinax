<#
Original Author: Josh Brower, Josh@DefensiveDepth.com
Version: 2016.05.23-Rev1

This script is licensed under the terms of the MIT license.

This script formats Sysinternals' AutoRunsc CSV Logs in a 
way that Security Onion can consume and parse using OSSEC & ELSA.

Tested with Autorunsc v13.51

Logs must be generated with the CSV output with TAB delimeter, 
and the resulting log should be named according to the system it
came from. For example:

autorunsc.exe -ct > $Hostname.csv

#>

(Get-ChildItem *.csv) |%{

#Store the name of the file & date
$SystemName = $_.Basename
$FileDate = $_.CreationTime

#Skips the header row and prepends the following to each message: Unique Identifer, System Name, Date
(Get-Content -Encoding Unicode $_.fullname | Select-Object -Skip 1) -replace "^","AR-LOG|$SystemName|$FileDate|"|

#Replaces the TAB delimeter with a Pipe delimeter (Syslog-NG does not support TAB)
Foreach-Object {$_ -replace '	','|'}  |

#Removes Autoruns' Subheaders
? { $_ -notmatch "\|\|\|\|\|\|\|\|\|\|" } |

#Appends the resulting message in ascii (OSSEC Windows Client does not support Unicode logs)
Out-File -Append -Encoding ascii -FilePath ar-normalized.log

#Deletes the consumed logfile
Remove-Item $_.fullname
 }
