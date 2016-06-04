<#
Original Author: Josh Brower, Josh@DefensiveDepth.com
Version: 2016.06.02-Rev1

This script is licensed under the terms of the MIT license.

This script compares Sysinternals' AutoRunsc CSV Logs with
a previously run log from the same system, filters out any
autoruns' entries that were removed, and outputs to a .csv
file in a format that the AR-Normalize script can understand.

Tested with Autorunsc v13.51

Logs must be generated with the CSV output with TAB delimeter, 
and the resulting log should be named according to the system it
came from. For example:

autorunsc.exe -ct > $Hostname.csv

#>

#Loop through the ToDiff folder for all CSV files
(Get-ChildItem .\ToDiff\*.csv) |%{

#Sets the Paths for ArchiveItem & NormalizeItem
$ArchiveItem = Join-Path -Path ".\Archive" -ChildPath $_.name
$ToNormItem = Join-Path -Path ".\ToNormalize" -ChildPath $_.name

#Checks to see if a logfile of the same name exists in the Archive folder
If ( (Test-Path -Path $ArchiveItem) )
    {
        #Since the log exists in Archive, we can go ahead and compare it. PassThru shows the entire line that is different.
        Compare-Object -ReferenceObject (Import-Csv -Delimiter "`t" -Encoding Unicode $ArchiveItem) -DifferenceObject (Import-Csv -Delimiter "`t" -Encoding Unicode $_.fullname) -Property SHA-1 -PassThru | 

        #Filters out removed entries
        ? {$_ -NotMatch "<="} | 

        #Converts the data to CSV with no Type header
        ConvertTo-Csv -NoTypeInformation | 

        #Removes the quotes that Powershell adds
        % { $_ -replace '","', '|'} | 

        #Removes more quotes that Powershell adds
        % { $_ -replace '^"(.*)"$', '$1'} | 

        #Writes the remaining data to the Normalize folder with the original filename
        Out-File -Encoding unicode -FilePath $ToNormItem

        #Moves the consumed logfile to the Archive folder
        Move-Item  -Path $_.fullname -Destination $ArchiveItem -Force
    }

Else {
        #Since the log does not exist it Archive, it must be a new client

        #Copy log to the Archive
        Copy-Item $_.fullname $ArchiveItem -Force

        #Move log to the Normalize folder
        Move-Item  -Path $_.fullname -Destination $ToNormItem -Force
     }

 }
