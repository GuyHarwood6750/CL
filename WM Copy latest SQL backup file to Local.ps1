#Warren Marine - Guy Harwood
#Purpose: To copy the SQL database file from Server location to local USB drive & Dropbox.
#
            $sourcepath = "\\wserver\backup"
            $destpath = "D:\Circe Launches Backups\SQL Circe Bookings"
            $dropbox ="C:\Users\Guy\Dropbox\SCS\Circe Launches"

            Remove-Item -path "$destpath\circe*"
            Remove-item -Path "$dropbox\circe*"

        Get-ChildItem -path "$sourcepath\circe*" -file | 
            Sort-Object -Property Modifiedtime -Descending | Select-Object -First 1 | 

            copy-item -destination $destpath -Force
            copy-item -path "$destpath\circe*" -destination $dropbox -Force