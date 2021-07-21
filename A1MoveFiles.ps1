Function A1 {[CmdletBinding(PositionalBinding = $true)]
   param(
      [Parameter(Mandatory = $true)]
      [ValidateNotNull()]
      [String] $suppliername, 
      [String] $month)
<# Move files            
 #>
   $serverbasefiles = "\\wserver\wmarine\Finance\Suppliers\"
   $year = " invoices statements 2021\"

Switch ($suppliername) {
      CASH {
         $sourceAllFiles = $serverbasefiles + $month + $year + '\' + "Cash Vouchers\"
         $destFile = $serverbasefiles + $month + $year + "Cash vouchers\in spreadsheet\"
         if (-Not (Test-Path -Path $destFile)) {
            Write-Error -Message "Folder does not exist '$destFile'. Error was: $_" -ErrorAction Stop
         }
         else {
            $bs = Get-ChildItem -Path $sourceALLFiles -file
            foreach ($bsf in $bs) {
               if ($bsf.name -like '*.*') {
                  $file = $bsf.Name
                  Move-Item -Path $sourceALLFiles\$file -Destination $destFile   
               }
               else {
               }
            }      
         }         
      }  
      CARD {
         $sourceAllFiles = $serverbasefiles + $month + $year + '\' + "Card Purchases\"
         $destFile = $serverbasefiles + $month + $year + "Card Purchases\in spreadsheet\"
         if (-Not (Test-Path -Path $destFile)) {
            Write-Error -Message "Folder does not exist '$destFile'. Error was: $_" -ErrorAction Stop
         }
         else {
            $bs = Get-ChildItem -Path $sourceALLFiles -file
            foreach ($bsf in $bs) {
               if ($bsf.name -like '*.*') {
                  $file = $bsf.Name
                  Move-Item -Path $sourceALLFiles\$file -Destination $destFile   
               }
               else {
               }
            }      
         }               
      }  
      DANSHAW {
         $sourceAllFiles = $serverbasefiles + $month + $year
         $destFile = $serverbasefiles + $month + $year + '\' + "Danshaw\"
         if (-Not (Test-Path -Path $destFile)) {
            Write-Error -Message "Folder does not exist '$destFile'. Error was: $_" -ErrorAction Stop
         }
         else {
            $bs = Get-ChildItem -Path $sourceALLFiles -file
            foreach ($bsf in $bs) {
               if ($bsf.name -like 'Danshaw*.*') {
                  $file = $bsf.Name
                  Move-Item -Path $sourceALLFiles\$file -Destination $destFile   
               }
               else {
               }
            }      
         }               
      } 
      BASTICKS {
         $sourceAllFiles = $serverbasefiles + $month + $year
         $destFile = $serverbasefiles + $month + $year + '\' + "Basticks\"
         if (-Not (Test-Path -Path $destFile)) {
            Write-Error -Message "Folder does not exist '$destFile'. Error was: $_" -ErrorAction Stop
         }
         else {
            $bs = Get-ChildItem -Path $sourceALLFiles -file
            foreach ($bsf in $bs) {
               if ($bsf.name -like 'Basticks*.*') {
                  $file = $bsf.Name
                  Move-Item -Path $sourceALLFiles\$file -Destination $destFile   
               }
               else {
               }
            }      
         }               
      } 
      CELLC {
         $sourceAllFiles = $serverbasefiles + $month + $year
         $destFile = $serverbasefiles + $month + $year + '\' + "Cell C\"
         if (-Not (Test-Path -Path $destFile)) {
            Write-Error -Message "Folder does not exist '$destFile'. Error was: $_" -ErrorAction Stop
         }
         else {
            $bs = Get-ChildItem -Path $sourceALLFiles -file
            foreach ($bsf in $bs) {
               if ($bsf.name -like 'CellC*.*') {
                  $file = $bsf.Name
                  Move-Item -Path $sourceALLFiles\$file -Destination $destFile   
               }
               else {
               }
            }      
         }               
      } 
      GOOGLE {
         $sourceAllFiles = $serverbasefiles + $month + $year
         $destFile = $serverbasefiles + $month + $year + '\' + "GOOGLE\"
         if (-Not (Test-Path -Path $destFile)) {
            Write-Error -Message "Folder does not exist '$destFile'. Error was: $_" -ErrorAction Stop
         }
         else {
            $bs = Get-ChildItem -Path $sourceALLFiles -file
            foreach ($bsf in $bs) {
               if ($bsf.name -like 'Google*.*') {
                  $file = $bsf.Name
                  Move-Item -Path $sourceALLFiles\$file -Destination $destFile   
               }
               else {
               }
            }      
         }               
      } 
      GULFSTREAM {
         $sourceAllFiles = $serverbasefiles + $month + $year
         $destFile = $serverbasefiles + $month + $year + '\' + "Gulfstream\"
         if (-Not (Test-Path -Path $destFile)) {
            Write-Error -Message "Folder does not exist '$destFile'. Error was: $_" -ErrorAction Stop
         }
         else {
            $bs = Get-ChildItem -Path $sourceALLFiles -file
            foreach ($bsf in $bs) {
               if ($bsf.name -like 'Gulfstream*.*') {
                  $file = $bsf.Name
                  Move-Item -Path $sourceALLFiles\$file -Destination $destFile   
               }
               else {
               }
            }      
         }               
      } 
      FOWKES {
         $sourceAllFiles = $serverbasefiles + $month + $year
         $destFile = $serverbasefiles + $month + $year + '\' + "Fowkes Bros\"
         if (-Not (Test-Path -Path $destFile)) {
            Write-Error -Message "Folder does not exist '$destFile'. Error was: $_" -ErrorAction Stop
         }
         else {
            $bs = Get-ChildItem -Path $sourceALLFiles -file
            foreach ($bsf in $bs) {
               if ($bsf.name -like 'Fowkes*.*') {
                  $file = $bsf.Name
                  Move-Item -Path $sourceALLFiles\$file -Destination $destFile   
               }
               else {
               }
            }      
         }               
      } 
      "1 Grid" {
         $sourceAllFiles = $serverbasefiles + $month + $year
         $destFile = $serverbasefiles + $month + $year + '\' + "1 Grid\"
         if (-Not (Test-Path -Path $destFile)) {
            Write-Error -Message "Folder does not exist '$destFile'. Error was: $_" -ErrorAction Stop
         }
         else {
            $bs = Get-ChildItem -Path $sourceALLFiles -file
            foreach ($bsf in $bs) {
               if ($bsf.name -like '1 Grid*.*') {
                  $file = $bsf.Name
                  Move-Item -Path $sourceALLFiles\$file -Destination $destFile   
               }
               else {
               }
            }      
         }               
      }   
}       
}
#A1 -suppliername 'CASH' -month '05July'
#A1 -suppliername 'CARD' -month '05July'
#A1 -suppliername 'CELLC' -month '05July'
#A1 -suppliername 'BASTICKS' -month '05July'
#A1 -suppliername 'DANSHAW' -month '05July'
#A1 -suppliername '1 Grid' -month '05July'
#A1 -suppliername 'GOOGLE' -month '05July'
#A1 -suppliername 'Fowkes' -month '04June'
#A1 -suppliername 'Gulfstream' -month '05July'
