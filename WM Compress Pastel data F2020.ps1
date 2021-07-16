#Backup Warren Marine current financial year Pastel files.

Compress-Archive -Path "C:\Pastel19\CIRCE21A" -DestinationPath "D:\Pastel Backups - Hout Bay\2021\CIRCE21A $(get-date -f yyyyMMdd-HHmmss).zip" -force

Compress-Archive -Path "C:\Pastel19\CIRCE21A" -DestinationPath "\\wserver\backup\PastelBKP\CIRCE21A $(get-date -f yyyyMMdd-HHmmss).zip" -force

Compress-Archive -Path "C:\Pastel19\CIRCE22A" -DestinationPath "D:\Pastel Backups - Hout Bay\2021\CIRCE22A $(get-date -f yyyyMMdd-HHmmss).zip" -force


Compress-Archive -Path "C:\Pastel19\CIRCE22A" -DestinationPath "\\wserver\backup\PastelBKP\CIRCE22A $(get-date -f yyyyMMdd-HHmmss).zip" -force

#Write-EventLog -LogName MyPowerShell -Source "WM" -EntryType Information -EventId 10 -Message "Archive of CIRCE20A data completed"

